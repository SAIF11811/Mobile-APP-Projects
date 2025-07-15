import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:flutter/material.dart';
import 'firstaid_screen.dart';

class LowBloodSugarScreen extends StatelessWidget {
  const LowBloodSugarScreen({super.key});

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
                    'Low Blood Sugar First Aid Steps:',
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
                      stepname: '1) Give Sugar',
                      direction:
                      'Offer juice, soda (not diet), candy, or glucose tablets.',
                      image: 'assets/images/givesugar.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '2) Watch & Repeat',
                      direction:
                      'If they feel better, give more sugar.',
                      image: 'assets/images/watch&repeat.png',
                    ),
                    SizedBox(height: 10),
                    firstaidsteps(
                      context,
                      stepname: '3) Get Help',
                      direction:
                      'Call emergency services if they don’t improve.',
                      image: 'assets/images/emergency.png',
                    ),

           SingleChildScrollView(
           child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left:4.0, top: 8),
                   child: Align(
                    alignment: Alignment.topLeft,
                  child: Text(
                    'FAQs:',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                         fontWeight: FontWeight.w700,
                         color: AppColors().colorofhint,
                         decoration: TextDecoration.underline,
                         decorationColor: AppColors().colorofhint,
                                        ),
                               ),
                       ),
               ),
                 SizedBox(height: 10),

                    Text(
                      '1) What causes low blood sugar?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors().maincolor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        'Skipping meals, too much insulin, or intense exercise.',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      '2) What should I give them?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors().maincolor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        'Juice, soda (not diet), jelly beans, chocolate, or glucose tablets/gel.',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      '3) Is it okay to give sugar if I’m not sure?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors().maincolor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        'No — it’s safer to give sugar if in doubt. It won’t cause harm.',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      '4) How do I know if they have diabetes?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors().maincolor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        'They may say so or have a medical ID bracelet, insulin pen, or glucose gel.',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      '5) What if they pass out?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors().maincolor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        'If unresponsive, follow general first aid: check breathing and act based on age and responsiveness.',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),



                  ]
                           ),
                      )
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
