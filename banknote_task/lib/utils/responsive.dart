import 'package:flutter/widgets.dart';

class Responsive {
  Responsive._();

  static const double mobileMax = 600;
  static const double tabletMax = 1000;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileMax;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobileMax && width < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletMax;

  static double contentMaxWidth(BuildContext context) {
    if (isDesktop(context)) return 480;
    if (isTablet(context)) return 440;
    return double.infinity;
  }

  static double horizontalPadding(BuildContext context) {
    if (isDesktop(context)) return 48;
    if (isTablet(context)) return 32;
    return 20;
  }

  static double logoSize(BuildContext context) {
    if (isMobile(context)) return 96;
    return 128;
  }
}
