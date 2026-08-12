import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/daily_call_summary.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/call_cell.dart';

class SummaryScreen extends StatelessWidget {
  final List<DailyCallSummary> weeklySummary;

  const SummaryScreen({super.key, required this.weeklySummary});

  static const _callColumnLabels = [
    '1ST CALL',
    '2ND CALL',
    '3RD CALL',
    '4TH CALL',
    '5TH CALL',
  ];

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('SUMMARY'),
      ),
      body: weeklySummary.isEmpty
          ? Center(
              child: Text(
                'No data yet. Submit a date first.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                final padding = Responsive.horizontalPadding(context);
                final columnSpacing = Responsive.isMobile(context) ? 24.0 : 40.0;

                return SingleChildScrollView(
                  padding: EdgeInsets.all(padding),
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth - padding * 2,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.divider),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: DataTable(
                        columnSpacing: columnSpacing,
                        columns: [
                          const DataColumn(label: Text('DATE')),
                          const DataColumn(label: Text('TOTAL CALLS')),
                          for (final label in _callColumnLabels)
                            DataColumn(label: Text(label)),
                        ],
                        rows: weeklySummary.map((day) {
                          return DataRow(cells: [
                            DataCell(Text(dateFormat.format(day.date))),
                            DataCell(Text('${day.totalCalls}')),
                            for (var i = 0; i < 5; i++)
                              DataCell(CallCell(entry: day.callAt(i))),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
