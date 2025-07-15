import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Authcubit/authcubit_cubit.dart';
import 'package:doctory/Components/components.dart';
import 'package:doctory/GetStartedScreen/home.dart';
import 'package:doctory/GetStartedScreen/login.dart';
import 'package:doctory/SharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  final FullNameController = TextEditingController();
  final PasswordController = TextEditingController();
  final EmailController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _agreeToTerms = false;
  String? _termsError;

  @override
  void initState() {
    super.initState();
    _loadAgreeToTerms();
  }

  void _loadAgreeToTerms() async {
    final agreed = await SharedPreferenceHelper.getAgreeToTerms();
    setState(() {
      _agreeToTerms = agreed;
    });
  }

  @override
  void dispose() {
    FullNameController.dispose();
    PasswordController.dispose();
    EmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AuthcubitCubit>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "New Account",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors().maincolor,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFDAEBFB),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 30, right: 30),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    DoctoryTextFormField(
                      context,
                      controller: FullNameController,
                      headeroftextformfield: 'Full Name',
                      hinttext: 'Omar Ahmed',
                      validationmessage: 'Please Enter Your Full Name',
                      Keyboard: TextInputType.text,
                    ),
                    SizedBoxformfield(),
                    DoctoryTextFormField(
                      context,
                      controller: EmailController,
                      headeroftextformfield: 'Email',
                      hinttext: 'example@example.com',
                      validationmessage: 'Please Enter Your Email',
                      Keyboard: TextInputType.emailAddress,
                    ),
                    SizedBoxformfield(),
                    DoctoryTextFormField(
                      context,
                      controller: PasswordController,
                      headeroftextformfield: "Password",
                      hinttext: "***********",
                      validationmessage: "Please enter your password",
                      Keyboard: TextInputType.visiblePassword,
                      obscure: !_isPasswordVisible,
                      suffixicon: !_isPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      suffixpressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    SizedBoxformfield(),

                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          _agreeToTerms = !_agreeToTerms;
                          _termsError = null;
                        });
                        await SharedPreferenceHelper.setAgreeToTerms(_agreeToTerms);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: _agreeToTerms,
                                onChanged: (value) async {
                                  setState(() {
                                    _agreeToTerms = value ?? false;
                                    _termsError = null;
                                  });
                                  await SharedPreferenceHelper.setAgreeToTerms(_agreeToTerms);
                                },
                                activeColor: AppColors().maincolor,
                              ),
                              Text(
                                'I agree to',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),
                              ),
                              SizedBox(width: 6),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        'Terms & Conditions',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(color: AppColors().maincolor),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Text(
                                          '''
This application utilizes artificial intelligence to provide general health-related information. It is not intended to serve as a substitute for professional medical advice, diagnosis, or treatment.

1. Users are solely responsible for the accuracy and completeness of the information they provide within the application.

2. This application does not offer emergency medical services or real-time clinical intervention.

3. The information provided is for educational and informational purposes only and may not be applicable to individual health conditions.

4. No physician-patient relationship is established by using this application.

5. The developers, licensors, and affiliates disclaim all liability for any direct, indirect, incidental, or consequential damages resulting from the use or misuse of this application.

6. By using this application, users agree to assume full responsibility for their health decisions and acknowledge the limitations of AI-generated content.

7. Use of this application is subject to acceptance of its Terms of Service and Privacy Policy.

For medical concerns, please consult a licensed healthcare professional.''',
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('Close',
                                              style: TextStyle(color: AppColors().maincolor)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Text(
                                  'Terms & Conditions',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors().maincolor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (_termsError != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                              child: Text(
                                _termsError!,
                                style: TextStyle(
                                  color: Colors.red[800],
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          SizedBox(height: 25),
                        ],
                      ),
                    ),

                    SizedBoxformfield(),

                    Align(
                      alignment: Alignment.center,
                      child: BlocConsumer<AuthcubitCubit, AuthcubitState>(
                        listenWhen: (previous, current) =>
                        current is AuthDone || current is AuthError,
                        listener: (context, state) async {
                          if (state is AuthDone) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          } else if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.message,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.red[900],
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: EdgeInsets.all(16),
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
                            text: "Sign Up",
                            function: () async {
                              setState(() {
                                _termsError = null;
                              });

                              if (formkey.currentState!.validate() && _agreeToTerms) {
                                await cubit.registerWithEmailAndPassword(
                                  email: EmailController.text.trim(),
                                  password: PasswordController.text.trim(),
                                  fullName: FullNameController.text.trim(),
                                );
                              } else if (!_agreeToTerms) {
                                setState(() {
                                  _termsError = 'You must agree to the terms and conditions.';
                                });
                              }
                            },
                            textcolor: Colors.white,
                          );
                        },
                      ),
                    ),
                    SizedBoxformfield(),

                    Column(
                      children: [
                        Text('or sign up with',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.black)),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.google,
                                color: AppColors().maincolor,
                                size: size.height * 0.05),
                            SizedBox(width: 10.0),
                            Icon(FontAwesomeIcons.facebook,
                                color: AppColors().maincolor,
                                size: size.height * 0.05),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 10.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'I already have an account?',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            gotoscreen(context, screen: LoginScreen());
                          },
                          child: Text(
                            'Log in',
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
