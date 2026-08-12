import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const background = Color(0xFF0B0B0A);
  static const surface = Color(0xFF17140F);
  static const surfaceVariant = Color(0xFF221D14);
  static const divider = Color(0xFF3A3324);

  static const gold = Color(0xFFD4AF37);
  static const goldLight = Color(0xFFF3D889);
  static const goldDark = Color(0xFF9C7A24);
  static const bronze = Color(0xFF8C7853);

  static const textPrimary = Color(0xFFF5EFE0);
  static const textSecondary = Color(0xFFBFB49B);

  static const error = Color(0xFFE0684B);

  static const goldGradient = LinearGradient(
    colors: [goldDark, gold, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final base = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.gold,
        onPrimary: Color(0xFF1A1400),
        secondary: AppColors.bronze,
        onSecondary: AppColors.textPrimary,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.error,
        onError: Colors.black,
      ),
      fontFamily: 'serif',
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.gold,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.gold,
          fontFamily: 'serif',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: const Color(0xFF1A1400),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.gold,
          side: const BorderSide(color: AppColors.gold, width: 1.2),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ).copyWith(
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled)
                ? AppColors.textSecondary
                : AppColors.gold,
          ),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(
              color: states.contains(WidgetState.disabled)
                  ? AppColors.divider
                  : AppColors.gold,
              width: 1.2,
            ),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.divider),
        ),
      ),
      dataTableTheme: DataTableThemeData(
        headingRowColor: WidgetStateProperty.all(AppColors.surfaceVariant),
        headingTextStyle: const TextStyle(
          color: AppColors.gold,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
        dataRowColor: WidgetStateProperty.all(AppColors.surface),
        dataTextStyle: const TextStyle(color: AppColors.textPrimary),
        dividerThickness: 0.6,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.divider),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.gold,
      ),
    );
  }
}
