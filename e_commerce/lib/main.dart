import 'package:e_commerce/src/view/screen/order_done_screen.dart';
import 'package:e_commerce/src/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/services.dart';
import 'package:e_commerce/core/app_theme.dart';
import 'package:e_commerce/src/view/screen/home_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: AppTheme.lightAppTheme,
    );
  }
}
