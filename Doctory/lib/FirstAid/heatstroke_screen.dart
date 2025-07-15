import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:flutter/material.dart';
import 'firstaid_screen.dart';

class HeatstrokeScreen extends StatelessWidget {
  const HeatstrokeScreen({super.key});

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
                    'How To Know If I Am Having a Heat Stroke?',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors().maincolor,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors().maincolor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:4.0, top: 8),
                  child: Text(
                    'First Aid Steps',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors().colorofhint,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors().colorofhint,
                    ),
                  ),
                ),
              ],

            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '1) Cool the Person',
                      direction:
                      'Put them in a cool tub or under a cool shower.',
                      image: 'assets/images/shower.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '2) Spray with Water',
                      direction:
                      'Use a garden hose to spray them down.',
                      image: 'assets/images/hose.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '3) Sponge the Skin',
                      direction:
                      'Apply cool water with a sponge.',
                      image: 'assets/images/sponge.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '4) Fan the Person',
                      direction:
                      'Fan them while misting with cool water.',
                      image: 'assets/images/fan.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '5) Apply Ice Packs',
                      direction:
                      'Place ice packs or cool wet towels on the neck, armpits, and groin.',
                      image: 'assets/images/ice.png',
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


