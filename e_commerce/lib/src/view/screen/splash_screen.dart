import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import '../animation/page_transition_switcher_wrapper.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _heartbeatController;
  late AnimationController _orbitController;
  late Animation<double> _heartbeatAnimation;
  late Animation<double> _textPulseAnimation;

  @override
  void initState() {
    super.initState();

    _heartbeatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);

    _heartbeatAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _heartbeatController, curve: Curves.easeInOut),
    );

    _textPulseAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _heartbeatController, curve: Curves.easeInOut),
    );

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    // Navigate after delay
    Future.delayed(const Duration(milliseconds: 4000), () {
      gotoHomeScreen();
    });
  }

  void gotoHomeScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const PageTransitionSwitcherWrapper(
          child: HomeScreen(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heartbeatController.dispose();
    _orbitController.dispose();
    super.dispose();
  }

  List<Widget> buildOrbitingStars(double radius) {
    const int starCount = 16;
    List<Widget> stars = [];

    for (int i = 0; i < starCount; i++) {
      double angle = (360 / starCount) * i;
      stars.add(_buildOrbitingStar(angle, radius));
    }

    return stars;
  }

  Widget _buildOrbitingStar(double angle, double radius) {
    return AnimatedBuilder(
      animation: _orbitController,
      builder: (context, child) {
        double rotation = _orbitController.value * 2 * pi;
        final double radians = (angle * pi / 180) + rotation;
        final double dx = radius * cos(radians);
        final double dy = radius * sin(radians);

        return Positioned(
          left: radius + dx,
          top: radius + dy,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double starOrbitRadius = 140;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: starOrbitRadius * 2,
                  height: starOrbitRadius * 2,
                  child: Stack(
                    children: buildOrbitingStars(starOrbitRadius),
                  ),
                ),

                AnimatedBuilder(
                  animation: _heartbeatController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _heartbeatAnimation.value,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 200,
                        height: 200,
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            AnimatedBuilder(
              animation: _textPulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _textPulseAnimation.value,
                  child: Column(
                    children: const [
                      Text(
                        "Welcome to EasyShop",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Your one-stop shop for everything you need.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
