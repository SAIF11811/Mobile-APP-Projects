import 'package:doctory/Authcubit/authcubit_cubit.dart';
import 'package:doctory/GetStartedScreen/startup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    BlocProvider(create: (context) => AuthcubitCubit(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFDAEBFB),
        appBarTheme: AppBarTheme(color: Color(0xFFDAEBFB)),
      ),
      debugShowCheckedModeBanner: false,
      home: StartUpScreen(),
    );
  }
}
