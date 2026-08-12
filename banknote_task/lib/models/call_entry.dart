import 'package:call_log/call_log.dart';

class CallEntry {
  final String? name;
  final String? formattedNumber;
  final DateTime timestamp;
  final int durationSeconds;
  final String callType;

  const CallEntry({
    required this.name,
    required this.formattedNumber,
    required this.timestamp,
    required this.durationSeconds,
    required this.callType,
  });

  factory CallEntry.fromCallLogEntry(CallLogEntry entry) {
    final rawTimestamp = entry.timestamp;
    final int timestampMillis = switch (rawTimestamp) {
      int value => value,
      String value => int.tryParse(value) ?? 0,
      _ => 0,
    };

    return CallEntry(
      name: entry.name,
      formattedNumber: entry.formattedNumber ?? entry.number,
      timestamp: DateTime.fromMillisecondsSinceEpoch(timestampMillis),
      durationSeconds: entry.duration ?? 0,
      callType: _callTypeLabel(entry.callType),
    );
  }

  static String _callTypeLabel(CallType? type) {
    switch (type) {
      case CallType.incoming:
        return 'Incoming';
      case CallType.outgoing:
        return 'Outgoing';
      case CallType.missed:
        return 'Missed';
      case CallType.voiceMail:
        return 'Voicemail';
      case CallType.rejected:
        return 'Rejected';
      case CallType.blocked:
        return 'Blocked';
      case CallType.answeredExternally:
        return 'Answered elsewhere';
      default:
        return 'Unknown';
    }
  }

  String get formattedDuration {
    final duration = Duration(seconds: durationSeconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }

  String get displayLabel {
    if (name != null && name!.trim().isNotEmpty) return name!;
    if (formattedNumber != null && formattedNumber!.trim().isNotEmpty) {
      return formattedNumber!;
    }
    return 'Unknown';
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'formattedNumber': formattedNumber,
        'timestamp': timestamp.millisecondsSinceEpoch,
        'durationSeconds': durationSeconds,
        'callType': callType,
      };

  factory CallEntry.fromJson(Map<String, dynamic> json) => CallEntry(
        name: json['name'] as String?,
        formattedNumber: json['formattedNumber'] as String?,
        timestamp:
            DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
        durationSeconds: json['durationSeconds'] as int,
        callType: json['callType'] as String,
      );
}
