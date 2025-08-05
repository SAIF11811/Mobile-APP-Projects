import 'package:flutter/material.dart';
import '../../../core/app_color.dart';
import 'home_screen.dart';

class OrderDoneScreen extends StatefulWidget {
  const OrderDoneScreen({super.key});

  @override
  State<OrderDoneScreen> createState() => _OrderDoneScreenState();
}

class _OrderDoneScreenState extends State<OrderDoneScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _truckAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;

      _truckAnimation = Tween<double>(
        begin: -200,
        end: screenWidth + 150,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
      );

      _controller.forward();

      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final truckX = (_truckAnimation.value).clamp(-200.0, screenWidth + 150);
          final revealPercent = ((truckX + 80) / screenWidth).clamp(0.0, 1.0);

          return Stack(
            children: [
              Positioned(
                top: screenHeight / 2 +10,
                left: 0,
                right: 0,
                child: Center(
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [
                          revealPercent,
                          (revealPercent + 0.001).clamp(0.0, 1.0),
                        ],
                        colors: const [
                          Colors.white,
                          Colors.transparent,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: const Text(
                      'On my way',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkOrange,
                      ),
                    ),
                  ),
                ),
              ),

              // Truck moving from left to right
              Positioned(
                top: screenHeight / 2 - 75,
                left: truckX,
                child: Image.asset(
                  'assets/images/truck.png',
                  width: 250,
                  height: 250,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
