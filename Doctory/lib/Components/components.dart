import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/BreastCancerPrediction/breast_cancer_predict.dart';
import 'package:doctory/BurnDetection/burn_detection.dart';
import 'package:doctory/DiabetesPrediction/diabetes_prediction.dart';
import 'package:doctory/DiseasePrediction/disease_prediction.dart';
import 'package:doctory/FirstAid/bitesstings_screen.dart';
import 'package:doctory/FirstAid/firstaid_screen.dart';
import 'package:doctory/FirstAid/heatstroke_screen.dart';
import 'package:doctory/FirstAid/hypothermia_screen.dart';
import 'package:doctory/FirstAid/lowbloodsugar_screen.dart';
import 'package:doctory/FirstAid/wounds_screen.dart';
import 'package:doctory/HealthCare/perfect_health_screen.dart';
import 'package:doctory/HeartDiseasePrediction/heart_prediction.dart';
import 'package:doctory/Models/items_model.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  required String text,
  required Function() function,
  Color background = Colors.blue,
  double width = double.infinity,
  double height = 40,
  double textfontsize = 25,
  Color textcolor = Colors.white,
  double radius = 0,
  bool isUpperCase = true,
}) => Container(
  width: width,
  height: height,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(fontSize: textfontsize, color: textcolor),
    ),
  ),
  decoration: BoxDecoration(
    color: background,
    borderRadius: BorderRadius.circular(radius),
  ),
);
//####################################################
Widget defaultFormField({
  required TextEditingController controller,
  String? label,
  required TextInputType keyboardType,
  required String? Function(String?)? validator,
  required IconData prefix,
  Color colorofLabel = Colors.blue,
  Color colorofborderside = Colors.blue,
  Color colorofTextinSide = Colors.black,
  IconData? suffix,
  Function()? suffixFunction,
  Function(String)? onChanged,
  Function(String)? onSubmit,
  Function()? onTap,
  bool obscure = false,
}) => TextFormField(
  controller: controller,
  onChanged: onChanged,
  onFieldSubmitted: onSubmit,
  onTap: onTap,
  decoration: InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorofborderside, style: BorderStyle.none),
    ),
    labelText: label,
    labelStyle: TextStyle(color: colorofLabel, fontSize: 20),
    prefixIcon: Icon(prefix),
    suffixIcon: IconButton(onPressed: suffixFunction, icon: Icon(suffix)),
  ),
  style: TextStyle(color: colorofTextinSide),
  obscureText: obscure,
  keyboardType: keyboardType,
  validator: validator,
);
//########################################################

Widget dataEntry({
  required String dataname,
  Color labelcolor = Colors.black,
  double radius = 20,
  required Function(String) onChanged,
  TextEditingController? controller,
  String? validationmessage,
}) {
  return Container(
    height: 50,
    width: 200,
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: dataname,
        labelStyle: TextStyle(
          color: labelcolor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(color: labelcolor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(color: labelcolor, width: 3),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationmessage;
        }
        return null;
      },
    ),
  );
}

//######################################################################

Widget DoctoryButton(
  BuildContext context, {
  var color,
  var text,
  Color textcolor = Colors.black,
  Function()? function,
  bool isLoading = false,
}) {
  if (isLoading) {
    return CircularProgressIndicator();
  }
  return ElevatedButton(
    onPressed: function,
    child: Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.displaySmall?.copyWith(color: textcolor),
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(color),
      fixedSize: MaterialStateProperty.all<Size>(
        Size(
          MediaQuery.of(context).size.width * 0.64,
          MediaQuery.of(context).size.height * 0.062,
        ),
      ),
    ),
  );
}
//######################################################################

Widget DoctoryTextFormField(
  BuildContext context, {
  required TextEditingController controller,
  required String headeroftextformfield,
  required String hinttext,
  String? validationmessage,
  IconData? suffixicon,
  Function()? suffixpressed,
  bool obscure = false,
  required TextInputType Keyboard,
  Function(String)? onchange,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        headeroftextformfield,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      TextFormField(
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(color: AppColors().maincolor),
        controller: controller,
        keyboardType: Keyboard,
        obscureText: obscure,
        onFieldSubmitted: (value) => print(value),
        onChanged: onchange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide.none,
          ),
          hintText: hinttext,
          hintStyle: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: AppColors().colorofhint),
          fillColor: AppColors().coloroftextformfield,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ), // Controls height
          suffixIcon:
              suffixicon != null
                  ? IconButton(
                    icon: Icon(suffixicon, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(), // ← Prevents expansion
                    onPressed: suffixpressed,
                  )
                  : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationmessage;
          }
          return null;
        },
      ),
    ],
  );
}

//#####################################################################
Widget SizedBoxformfield() => SizedBox(height: 10.0);
//#####################################################################

Future gotoscreen(BuildContext context, {required Widget screen}) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

//#####################################################################
AppBar AppBarOfScreen(BuildContext context, {required text}) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColors().maincolor,
        size: MediaQuery.of(context).size.height * 0.03,
      ),
    ),
    title: Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors().maincolor,
      ),
    ),
    centerTitle: true,
    backgroundColor: Color(0xFFDAEBFB),
  );
}

//######################################################################
Widget buildDropdown({
  required BuildContext context,
  required String label,
  required String? value,
  required List<String> items,
  required void Function(String?) onChanged,
  required String hint,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        hint: Text(
          hint,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: AppColors().colorofhint),
        ),
        // Prevent text overflow
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide.none,
          ),
          hintText: hint,
          filled: true,
          fillColor: AppColors().coloroftextformfield,
          hintStyle: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: AppColors().colorofhint),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: AppColors().maincolor, // Selected item text color
          fontWeight: FontWeight.w500,
        ),
        dropdownColor: AppColors().coloroftextformfield,
        icon: const Icon(Icons.arrow_drop_down),
        items:
            items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                )
                .toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select $label' : null,
      ),
    ],
  );
}

//######################################################################
Widget homeCard(BuildContext context, {required homeitem homeItem}) {
  List<Widget> screens = [
    PerfectHealthScreen(),
    Predict(),
    HeartDiseaseScreen(),
    BreastCancerPredictScreen(),
    DiabetesScreen(),
    FirstaidScreen(),
    BurnDetectionScreen(),
  ];
  var size=MediaQuery.of(context).size;
  return InkWell(
    onTap: () {
      gotoscreen(context, screen: screens[homeItem.dest]);
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: AppColors().cardColors,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Container(
                        height: size.height*0.16,
                        width: size.width*0.35,
                        child: Image.asset(homeItem.imgPath, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child:    SizedBox(
                            child: FittedBox(
                              child:Text(
                                homeItem.name,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: AppColors().titleCardColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                homeItem.brief,
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: MediaQuery.of(context).size.width * 0.033, // adjust size based on screen width
                                ),
                                //softWrap: true,
                              ),
                            ),


                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

//######################################################################
Widget HomeCardListView() {
  return ListView.separated(
    shrinkWrap: true,
    padding: EdgeInsets.all(8),
    separatorBuilder: (context, index) => SizedBox(),
    itemCount: home.length,
    itemBuilder: (context, index) => homeCard(context, homeItem: home[index]),
  );
}

//######################################################################
Widget firstaidCard(
  BuildContext context, {
  required FirstAidItem firstaidItem,
}) {
  List<Widget> FirstAidScreens = [
    HeatstrokeScreen(),
    BitesStingsScreen(),
    WoundScreen(),
    HypothermiaScreen(),
    LowBloodSugarScreen(),
  ];
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FirstAidScreens[firstaidItem.ScreenNo],
        ),
      );
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Card(
              color: AppColors().cardColors2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.14,
                          width: MediaQuery.of(context).size.height * 0.145,
                          child: Image.asset(
                            firstaidItem.img,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SizedBox(
                                child: FittedBox(
                                  child: Text(
                                    firstaidItem.title,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall?.copyWith(
                                      color: AppColors().maincolor,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

//######################################################################
Widget fistaidCardListView() {
  return Expanded(
    child: ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      separatorBuilder: (context, index) => SizedBox(),
      itemCount: firstaid.length,
      itemBuilder:
          (context, index) =>
              firstaidCard(context, firstaidItem: firstaid[index]),
    ),
  );
}

//######################################################################
Widget firstaidsteps(
  BuildContext context, {
  required String stepname,
  required String direction,
  required String image,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          color: AppColors().cardColors2,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors().maincolor, width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            stepname,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors().maincolor,
            ),
          ),
        ),
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.119,
              width: MediaQuery.of(context).size.width * 0.23,
              child: Image.asset(image, fit: BoxFit.contain),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              direction,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            // color: Colors.grey.shade400
            color: AppColors().cardColors2,
          ),
        ),
      ),
      SizedBox(height: 2),
    ],
  );
}
