import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controllers/call_log_controller.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'summary_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CallLogController _controller = CallLogController();
  final TextEditingController _dateTextController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void dispose() {
    _controller.dispose();
    _dateTextController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _controller.selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.gold,
                  onPrimary: const Color(0xFF1A1400),
                  surface: AppColors.surface,
                  onSurface: AppColors.textPrimary,
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _controller.setSelectedDate(picked);
    }
  }

  void _openSummary() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SummaryScreen(weeklySummary: _controller.weeklySummary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final dateStr = _controller.selectedDate != null
            ? _dateFormat.format(_controller.selectedDate!)
            : '';
        if (_dateTextController.text != dateStr) {
          _dateTextController.text = dateStr;
        }

        return Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final horizontalPadding = Responsive.horizontalPadding(context);
                final cardPadding = Responsive.isMobile(context) ? 20.0 : 28.0;

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    32,
                    horizontalPadding,
                    24,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: Responsive.contentMaxWidth(context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const _Header(),
                          const SizedBox(height: 36),
                          Container(
                            padding: EdgeInsets.all(cardPadding),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.divider),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'REFERENCE DATE',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: AppColors.goldLight,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: _dateTextController,
                                  readOnly: true,
                                  onTap: _controller.isLoading ? null : _pickDate,
                                  style:
                                      const TextStyle(color: AppColors.textPrimary),
                                  decoration: const InputDecoration(
                                    hintText: 'Tap to choose a date',
                                    suffixIcon: Icon(
                                      Icons.calendar_today,
                                      color: AppColors.gold,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                if (_controller.errorMessage != null) ...[
                                  Row(
                                    children: [
                                      const Icon(Icons.error_outline,
                                          color: AppColors.error, size: 18),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          _controller.errorMessage!,
                                          style: const TextStyle(
                                              color: AppColors.error),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                ],
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    FilledButton(
                                      onPressed: _controller.isLoading
                                          ? null
                                          : () => _controller.submit(),
                                      child: _controller.isLoading
                                          ? const SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Color(0xFF1A1400),
                                              ),
                                            )
                                          : const Text('SUBMIT'),
                                    ),
                                    const SizedBox(height: 12),
                                    OutlinedButton(
                                      onPressed: (_controller.hasData &&
                                              !_controller.isRestoring)
                                          ? _openSummary
                                          : null,
                                      child: const Text('SUMMARY'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (_controller.hasData)
                            Text(
                              'Loaded call logs from '
                              '${_dateFormat.format(_controller.selectedDate!.subtract(const Duration(days: 6)))} '
                              'to '
                              '${_dateFormat.format(_controller.selectedDate!)}.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final logoSize = Responsive.logoSize(context);
    final titleSize = Responsive.isMobile(context) ? 20.0 : 24.0;

    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: logoSize,
          width: logoSize,
        ),
        const SizedBox(height: 16),
        ShaderMask(
          shaderCallback: (bounds) => AppColors.goldGradient.createShader(bounds),
          child: Text(
            'BANKNOTE FINANCIAL',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'serif',
              fontSize: titleSize,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'CALL LOG SUMMARY',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            letterSpacing: 4,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
