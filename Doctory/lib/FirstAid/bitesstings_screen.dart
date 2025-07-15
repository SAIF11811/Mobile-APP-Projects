import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:flutter/material.dart';
import 'firstaid_screen.dart';

class BitesStingsScreen extends StatelessWidget {
  const BitesStingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header and Back Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstaidScreen()),
                  );
                },
                child: Icon(
                  Icons.chevron_left,
                  size: height * 0.04,
                  color: AppColors().maincolor,
                ),
              ),
              SizedBox(height: height * 0.015),
              Text(
                'Bites and Stings First Aid Steps:',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors().maincolor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors().maincolor,
                ),
              ),
              // Steps
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.01),
                      firstaidsteps(
                        context,
                        stepname: '1) Move to Safety',
                        direction: 'Go to a safe area to avoid more bites or stings.',
                        image: 'assets/images/safearea.png',
                      ),
                      SizedBox(height: height * 0.015),
                      firstaidsteps(
                        context,
                        stepname: '2) Remove Stingers',
                        direction: 'Use a scraping motion (not tweezers) to gently remove any stinger.',
                        image: 'assets/images/stingers.png',
                      ),
                      SizedBox(height: height * 0.015),
                      firstaidsteps(
                        context,
                        stepname: '3) Wash Area',
                        direction: 'Clean the bite or sting with soap and water.',
                        image: 'assets/images/washhand.png',
                      ),
                      SizedBox(height: height * 0.015),
                      firstaidsteps(
                        context,
                        stepname: '4) Apply Cold',
                        direction: 'Use a damp cloth or ice pack on the area for 10–20 minutes to ease pain and swelling.',
                        image: 'assets/images/icepack.png',
                      ),
                      SizedBox(height: height * 0.015),
                      firstaidsteps(
                        context,
                        stepname: '5) Elevate',
                        direction: 'If the bite is on an arm or leg, raise it to reduce swelling.',
                        image: 'assets/images/raise.png',
                      ),
                      SizedBox(height: height * 0.015),
                      firstaidsteps(
                        context,
                        stepname: '6) Soothe Skin',
                        direction: 'Apply calamine lotion, baking soda paste, or 0.5–1% hydrocortisone cream a few times daily',
                        image: 'assets/images/soothe.png',
                      ),
                      SizedBox(height: height * 0.015),
                      firstaidsteps(
                        context,
                        stepname: '7) Relieve Symptoms',
                        direction: 'Take an oral antihistamine to reduce itching. Use a nonprescription pain reliever if needed for pain.',
                        image: 'assets/images/antiitching.png',
                      ),
                      SizedBox(height: height * 0.03),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
