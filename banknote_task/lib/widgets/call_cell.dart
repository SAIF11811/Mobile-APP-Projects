import 'package:flutter/material.dart';

import '../models/call_entry.dart';
import '../theme/app_theme.dart';

class CallCell extends StatelessWidget {
  final CallEntry? entry;

  const CallCell({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final call = entry;
    if (call == null) {
      return const Text('—', style: TextStyle(color: AppColors.textSecondary));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          call.formattedDuration,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.gold,
          ),
        ),
        Text(
          call.displayLabel,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
