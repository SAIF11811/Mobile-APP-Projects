import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Authcubit/authcubit_cubit.dart';
import 'package:doctory/Components/components.dart';
import 'package:doctory/GetStartedScreen/home.dart';
import 'package:doctory/GetStartedScreen/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedLogin();
  }

  void _loadSavedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? remember = prefs.getBool('remember_me') ?? false;

    if (remember) {
      setState(() {
        _rememberMe = true;
      });
    }
  }

  void _saveLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setBool('remember_me', true);
      await prefs.setString('saved_email', emailController.text.trim());
      await prefs.setString('saved_password', passwordController.text);
    } else {
      await prefs.setBool('remember_me', false);
      await prefs.remove('saved_email');
      await prefs.remove('saved_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthcubitCubit>(context);
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Log In",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors().maincolor,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFDAEBFB),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 30, right: 30),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: AppColors().maincolor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Powered by AI to help you identify symptoms, understand your condition, and get the care you need — anytime, anywhere',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.black),
                    ),
                    SizedBox(height: size.height * 0.05),
                    DoctoryTextFormField(
                      context,
                      controller: emailController,
                      headeroftextformfield: 'Email or Mobile Number',
                      hinttext: "example@example.com",
                      validationmessage: "Enter your Email please",
                      Keyboard: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10.0),
                    DoctoryTextFormField(
                      context,
                      controller: passwordController,
                      headeroftextformfield: "Password",
                      hinttext: "***********",
                      validationmessage: "You must enter your password",
                      obscure: !_isPasswordVisible,
                      suffixicon: !_isPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      suffixpressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      Keyboard: TextInputType.text,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                          activeColor: AppColors().maincolor,
                        ),
                        const Text(
                          "Remember me",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.center,
                      child: BlocConsumer<AuthcubitCubit, AuthcubitState>(
                        bloc: cubit,
                        listenWhen: (previous, current) =>
                        current is AuthDone || current is AuthError,
                        listener: (context, state) {
                          if (state is AuthDone) {
                            _saveLoginInfo();
                            gotoscreen(context, screen: HomeScreen());
                          } else if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.message,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.red[900],
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        },
                        buildWhen: (previous, current) =>
                        current is AuthLoading ||
                            current is AuthError ||
                            current is AuthDone,
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return DoctoryButton(context, isLoading: true);
                          }
                          return DoctoryButton(
                            context,
                            color: AppColors().maincolor,
                            text: "Log In",
                            textcolor: Colors.white,
                            function: () async {
                              if (formKey.currentState!.validate()) {
                                await cubit.loginWithEmailAndPassword(
                                  emailController.text.trim(),
                                  passwordController.text,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Column(
                      children: [
                        Text(
                          'or sign up with',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.google,
                              color: AppColors().maincolor,
                              size: size.height * 0.05,
                            ),
                            const SizedBox(width: 10.0),
                            Icon(
                              FontAwesomeIcons.facebook,
                              color: AppColors().maincolor,
                              size: size.height * 0.05,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            gotoscreen(context, screen: SignupScreen());
                          },
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              color: AppColors().maincolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
