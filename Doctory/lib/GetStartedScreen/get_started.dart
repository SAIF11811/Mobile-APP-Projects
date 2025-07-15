import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Authcubit/authcubit_cubit.dart';
import 'package:doctory/Components/components.dart';
import 'package:doctory/GetStartedScreen/login.dart';
import 'package:doctory/GetStartedScreen/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String text =
        'Doctory is your smart health companion, offering personalized insights and AI tools for medical support.';

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
      body: Padding(
        padding: EdgeInsetsGeometry.all(8.0),
        child: Center(
          child: SafeArea(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  "assets/doctorylogowithoutbackground.png",
                  fit: BoxFit.cover,
                  height: size.height * 0.35,
                ),
                Text(
                  'Doctory',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Color(0xFF0961DF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.06),
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.05),
                DoctoryButton(
                  context,
                  color: AppColors().maincolor,
                  text: "Log In",
                  textcolor: Colors.white,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => BlocProvider(
                          create: (context) => AuthcubitCubit(),
                          child: LoginScreen(),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.02),
                DoctoryButton(
                  context,
                  color: AppColors().secondarycolor,
                  text: "Sign Up",
                  textcolor: AppColors().maincolor,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
