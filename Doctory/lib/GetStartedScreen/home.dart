import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:doctory/GetStartedScreen/login.dart';
import 'package:doctory/SharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            iconSize: 30,
            color: AppColors().maincolor,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Sign Out',
                    style: TextStyle(color: AppColors().maincolor),
                  ),
                  content: Text(
                    'Are you sure you want to sign out?',
                    style: TextStyle(fontSize: 18),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors().maincolor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        gotoscreen(context, screen: LoginScreen());
                        await SharedPreferenceHelper.setRememberMe(false);
                        await SharedPreferenceHelper.setAgreeToTerms(false);
                      },
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          color: AppColors().maincolor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.1416),
              child: Icon(Icons.exit_to_app),
            ),
          ),
          title: Text(
            'Home Menu',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors().maincolor,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFDAEBFB),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Image.asset(
                'assets/coverphoto.png',
                height: size.height*0.25,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: HomeCardListView(),
            ),
          ],
        ),
      ),
    );
  }
}
