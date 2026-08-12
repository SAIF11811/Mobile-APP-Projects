import 'dart:convert';

import 'package:call_log/call_log.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/call_entry.dart';
import '../models/daily_call_summary.dart';

class CallLogController extends ChangeNotifier {
  static const _prefsDateKey = 'call_log_controller.selected_date';
  static const _prefsSummaryKey = 'call_log_controller.weekly_summary';

  DateTime? selectedDate;
  bool isLoading = false;
  bool isRestoring = true;
  String? errorMessage;

  List<DailyCallSummary> weeklySummary = [];

  bool get hasData => weeklySummary.isNotEmpty;

  CallLogController() {
    _restorePersisted();
  }

  Future<void> _restorePersisted() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final dateMillis = prefs.getInt(_prefsDateKey);
      if (dateMillis != null) {
        selectedDate = DateTime.fromMillisecondsSinceEpoch(dateMillis);
      }

      final summaryJson = prefs.getString(_prefsSummaryKey);
      if (summaryJson != null) {
        final decoded = jsonDecode(summaryJson) as List<dynamic>;
        weeklySummary = decoded
            .map((e) => DailyCallSummary.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {
    } finally {
      isRestoring = false;
      notifyListeners();
    }
  }

  Future<void> _persist() async {
    final date = selectedDate;
    if (date == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefsDateKey, date.millisecondsSinceEpoch);
    await prefs.setString(
      _prefsSummaryKey,
      jsonEncode(weeklySummary.map((d) => d.toJson()).toList()),
    );
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    weeklySummary = [];
    errorMessage = null;
    notifyListeners();
  }

  Future<void> submit() async {
    final date = selectedDate;
    if (date == null) {
      errorMessage = 'Please choose a date first.';
      notifyListeners();
      return;
    }

    errorMessage = null;
    isLoading = true;
    notifyListeners();

    try {
      final granted = await _requestCallLogPermission();
      if (!granted) {
        errorMessage = 'Call log permission was denied.';
        return;
      }

      final selectedDay = DateTime(date.year, date.month, date.day);
      final startDate = selectedDay.subtract(const Duration(days: 6));
      final inclusiveEnd = selectedDay
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1));

      final rawEntries = await CallLog.query(
        dateFrom: startDate.millisecondsSinceEpoch,
        dateTo: inclusiveEnd.millisecondsSinceEpoch,
      );

      final entries = rawEntries.map(CallEntry.fromCallLogEntry).toList();
      weeklySummary = _buildWeeklySummary(entries, startDate);
      await _persist();
    } catch (e) {
      errorMessage = 'Failed to load call logs: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> _requestCallLogPermission() async {
    final status = await Permission.phone.status;
    if (status.isGranted) return true;
    final result = await Permission.phone.request();
    return result.isGranted;
  }

  List<DailyCallSummary> _buildWeeklySummary(
    List<CallEntry> entries,
    DateTime startDate,
  ) {
    return List.generate(7, (i) {
      final day = DateTime(startDate.year, startDate.month, startDate.day)
          .add(Duration(days: i));

      final dayEntries = entries.where((e) {
        return e.timestamp.year == day.year &&
            e.timestamp.month == day.month &&
            e.timestamp.day == day.day;
      }).toList();

      dayEntries.sort((a, b) => b.durationSeconds.compareTo(a.durationSeconds));

      return DailyCallSummary(
        date: day,
        totalCalls: dayEntries.length,
        topCalls: dayEntries.take(5).toList(),
      );
    });
  }
}
