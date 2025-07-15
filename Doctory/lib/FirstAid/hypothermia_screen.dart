import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:doctory/FirstAid/firstaid_screen.dart';
import 'package:flutter/material.dart';

class HypothermiaScreen extends StatelessWidget {
  const HypothermiaScreen({super.key});

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
                    'How To Know If I Have Hypothermia?',
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
                      stepname: '1) Be Gentle',
                      direction:
                      'Handle the person gently. Avoid rubbing or shaking to prevent heart complications.',
                      image: 'assets/images/begentle.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '2) Move Indoors',
                      direction:
                      'Get them into a warm, dry place if possible.',
                      image: 'assets/images/moveperson.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '3) Remove Wet Clothes',
                      direction:
                      'Take off wet clothing to reduce heat loss.',
                      image: 'assets/images/removewet.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '4) Cover With Blankets',
                      direction:
                      'Wrap in dry blankets or coats. Cover the head, leave the face exposed.',
                      image: 'assets/images/coverperson.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '5) Insulate From Ground',
                      direction:
                      'Lay the person on a warm surface like a blanket.',
                      image: 'assets/images/insulate.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '6) Check Breathing',
                      direction:
                      'If breathing is dangerously slow or stopped, begin CPR if trained.',
                      image: 'assets/images/monitor.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '7) Give Warm Drinks',
                      direction:
                      'Offer warm, sweet, nonalcoholic drinks if they’re alert and able to swallow.',
                      image: 'assets/images/warmbeverage.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '8) Avoid Direct Heat',
                      direction:
                      'Don’t use hot water, heating pads, or lamps. This can cause skin damage or heart issues.',
                      image: 'assets/images/dontapplyheat.png',
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

