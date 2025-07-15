import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/GetStartedScreen/get_started.dart';
import 'package:doctory/GetStartedScreen/home.dart';
import 'package:doctory/SharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartUpScreen extends StatefulWidget {
  @override
  _StartUpScreenState createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;

  late AnimationController _textController;
  late Animation<Offset> _appNameSlide;
  late Animation<double> _appNameOpacity;

  late AnimationController _bgPulseController;
  late Animation<double> _bgPulse;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _logoController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );
    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    _textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _appNameSlide = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));
    _appNameOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    _bgPulseController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _bgPulse = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _bgPulseController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() async {
    await _logoController.forward();
    await _textController.forward();
    await Future.delayed(Duration(milliseconds: 500));

    bool remember = await SharedPreferenceHelper.getRememberMe();
    bool agreed = await SharedPreferenceHelper.getAgreeToTerms();

    Widget nextScreen = (remember || agreed) ? HomeScreen() : GetStartedScreen();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => nextScreen,
          transitionDuration: Duration(milliseconds: 800),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _bgPulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.06),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _bgPulse,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _bgPulse.value,
                          child: Container(
                            width: size.height * 0.4,
                            height: size.height * 0.4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors().maincolor.withOpacity(0.1),
                            ),
                          ),
                        );
                      },
                    ),
                    Column(
                      children: [
                        AnimatedBuilder(
                          animation: _logoController,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _logoOpacity.value,
                              child: Transform.scale(
                                scale: _logoScale.value,
                                child: Image.asset(
                                  "assets/doctorylogowithoutbackground.png",
                                  height: size.height * 0.18,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        AnimatedBuilder(
                          animation: _textController,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _appNameOpacity.value,
                              child: SlideTransition(
                                position: _appNameSlide,
                                child: Text(
                                  'Doctory',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                    color: AppColors().maincolor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
