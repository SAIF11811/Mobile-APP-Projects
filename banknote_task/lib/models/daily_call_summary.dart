import 'call_entry.dart';

class DailyCallSummary {
  final DateTime date;
  final int totalCalls;

  final List<CallEntry> topCalls;

  const DailyCallSummary({
    required this.date,
    required this.totalCalls,
    required this.topCalls,
  });

  CallEntry? callAt(int index) {
    if (index < 0 || index >= topCalls.length) return null;
    return topCalls[index];
  }

  Map<String, dynamic> toJson() => {
        'date': date.millisecondsSinceEpoch,
        'totalCalls': totalCalls,
        'topCalls': topCalls.map((e) => e.toJson()).toList(),
      };

  factory DailyCallSummary.fromJson(Map<String, dynamic> json) =>
      DailyCallSummary(
        date: DateTime.fromMillisecondsSinceEpoch(json['date'] as int),
        totalCalls: json['totalCalls'] as int,
        topCalls: (json['topCalls'] as List<dynamic>)
            .map((e) => CallEntry.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
