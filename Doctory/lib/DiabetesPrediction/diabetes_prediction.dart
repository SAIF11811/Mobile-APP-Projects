import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:doctory/DiabetesPrediction/diabetes_result.dart';
import 'package:flutter/material.dart';

class DiabetesScreen extends StatefulWidget {
  const DiabetesScreen({super.key});

  @override
  _DiabetesScreenState createState() => _DiabetesScreenState();
}

class _DiabetesScreenState extends State<DiabetesScreen> {
  final List<String> data = [
    'gender',
    'age',
    'hypertension',
    'heart disease',
    'smoking history',
    'bmi',
    'HbA1c level',
    'blood glucose level'
  ];

  late List<TextEditingController> controllers;
  final _formKey = GlobalKey<FormState>();

  int? genderValue;
  int? hypertensionValue;
  int? heartDiseaseValue;
  int? smokingHistoryValue;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(data.length, (_) => TextEditingController());
  }

  void resetInputs() {
    setState(() {
      for (var controller in controllers) {
        controller.clear();
      }
      genderValue = null;
      hypertensionValue = null;
      heartDiseaseValue = null;
      smokingHistoryValue = null;
    });
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Widget buildInputField(int index, double height) {
    final String field = data[index];

    switch (field) {
      case 'gender':
        return buildDropdown(
          context: context,
          label: 'Gender',
          value: genderValue == null ? null : (genderValue == 1 ? 'Male' : 'Female'),
          items: ['Male', 'Female'],
          onChanged: (value) {
            setState(() {
              genderValue = value == 'Male' ? 1 : 0;
            });
          },
          hint: 'Select your gender',
        );

      case 'hypertension':
        return Column(
          children: [
            SizedBoxformfield(),
            buildDropdown(
              context: context,
              label: 'Hypertension',
              value: hypertensionValue == null
                  ? null
                  : (hypertensionValue == 1 ? 'Have Hypertension' : 'Have Not Hypertension'),
              items: ['Have Hypertension', 'Have Not Hypertension'],
              onChanged: (value) {
                setState(() {
                  hypertensionValue = value == 'Have Hypertension' ? 1 : 0;
                });
              },
              hint: 'Select your hypertension status',
            ),
          ],
        );

      case 'heart disease':
        return Column(
          children: [
            SizedBoxformfield(),
            buildDropdown(
              context: context,
              label: 'Heart Disease',
              value: heartDiseaseValue == null
                  ? null
                  : (heartDiseaseValue == 1 ? 'Have Heart Disease' : 'Have Not Heart Disease'),
              items: ['Have Heart Disease', 'Have Not Heart Disease'],
              onChanged: (value) {
                setState(() {
                  heartDiseaseValue = value == 'Have Heart Disease' ? 1 : 0;
                });
              },
              hint: 'Select your heart condition',
            ),
          ],
        );

      case 'smoking history':
        final smokingOptions = {
          0: 'No Information',
          1: 'Current',
          2: 'Ever',
          3: 'Former',
          4: 'Never',
          5: 'Not Current',
        };

        return Column(
          children: [
            SizedBoxformfield(),
            buildDropdown(
              context: context,
              label: 'Smoking History',
              value: smokingHistoryValue == null ? null : smokingOptions[smokingHistoryValue],
              items: smokingOptions.values.toList(),
              onChanged: (value) {
                setState(() {
                  final int newValue = smokingOptions.entries
                      .firstWhere((entry) => entry.value == value)
                      .key;
                  smokingHistoryValue = newValue;
                });
              },
              hint: 'Select your smoking history',
            ),
          ],
        );

      default:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          child: DoctoryTextFormField(
            context,
            controller: controllers[index],
            headeroftextformfield: field,
            hinttext: 'Enter $field',
            validationmessage: 'Please enter $field',
            Keyboard: TextInputType.number,
          ),
        );
    }
  }

  Map<String, dynamic> gatherInputs() {
    return {
      "gender": genderValue ?? 0,
      "age": double.tryParse(controllers[data.indexOf('age')].text) ?? 0,
      "hypertension": hypertensionValue ?? 0,
      "heart_disease": heartDiseaseValue ?? 0,
      "smoking_history": smokingHistoryValue ?? 0,
      "bmi": double.tryParse(controllers[data.indexOf('bmi')].text) ?? 0,
      "HbA1c_level": double.tryParse(controllers[data.indexOf('HbA1c level')].text) ?? 0,
      "blood_glucose_level":
      double.tryParse(controllers[data.indexOf('blood glucose level')].text) ?? 0,
    };
  }

  bool areDropdownsValid() {
    return genderValue != null &&
        hypertensionValue != null &&
        heartDiseaseValue != null &&
        smokingHistoryValue != null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBarOfScreen(context, text: 'Diabetes Prediction'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: List.generate(
                      data.length,
                          (index) => buildInputField(index, height),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.02,
              ),
              child: DoctoryButton(
                context,
                color: AppColors().maincolor,
                text: "Predict",
                textcolor: Colors.white,
                function: () {
                  if (_formKey.currentState!.validate() && areDropdownsValid()) {
                    final inputMap = gatherInputs();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiabetesResult(inputs: inputMap),
                      ),
                    ).then((_) => resetInputs());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
