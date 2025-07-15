import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:doctory/FirstAid/firstaid_screen.dart';
import 'package:flutter/material.dart';

class WoundScreen extends StatelessWidget {
  const WoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FirstaidScreen()),
                      );
                    },
                    child: Icon(
                      Icons.chevron_left,
                      size: size.height * 0.043,
                      color: AppColors().maincolor,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    'Wounds First Aid Steps:',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors().maincolor,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors().maincolor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '1) Control Bleeding',
                      direction:
                      'Press firmly using a clean, dry towel. Hold longer if taking blood thinners.',
                      image: 'assets/images/controlbleeding.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '2) Wash Your Hands Well',
                      direction:
                      'Wash hands well to prevent germs from entering wounds.',
                      image: 'assets/images/washhand.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '3) Rinse the wound',
                      direction:
                      'Rinse the wound with clean water to prevent infection.',
                      image: 'assets/images/rinsewound.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '4) Dry the Wound',
                      direction:
                      'Gently pat dry the surrounding skin with a clean pad or towel.',
                      image: 'assets/images/drywound.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '5) Replace any skin flaps if possible',
                      direction:
                      'Gently cover the wound with the attached skin flap using a moist pad.',
                      image: 'assets/images/skinflap.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '6) Cover the Wound',
                      direction:
                      'Use a gentle bandage with non-stick dressing. Avoid tape on fragile skin.',
                      image: 'assets/images/coverwound.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '7) Seek Help',
                      direction:
                      'Contact a healthcare provider promptly for treatment and advice.',
                      image: 'assets/images/seekhelp.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '8) Manage Pain',
                      direction:
                      'Wounds may hurt, so ask your doctor about pain relief options.',
                      image: 'assets/images/managepain.png',
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}