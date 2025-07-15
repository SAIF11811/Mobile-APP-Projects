import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:doctory/HealthCare/perfect_health_result.dart';
import 'package:flutter/material.dart';

class PerfectHealthScreen extends StatefulWidget {
  const PerfectHealthScreen({super.key});

  @override
  _PerfectHealthScreenState createState() => _PerfectHealthScreenState();
}

class _PerfectHealthScreenState extends State<PerfectHealthScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? _selectedSex;
  String? _selectedActivityLevel;
  String? _selectedGoal;

  final Map<String, double> activityMultipliers = {
    'Sedentary (little or no exercise)': 1.2,
    'Lightly active (1-3 days/week)': 1.375,
    'Moderately active (3-5 days/week)': 1.55,
    'Very active (6-7 days/week)': 1.725,
    'Super active (very hard exercise & physical job)': 1.9,
  };

  final List<String> goals = ['Lose Weight', 'Maintain Weight', 'Gain Weight'];

  void _onCalculate() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedSex == null) {
      _showSnackBar('Please select your sex');
      return;
    }
    if (_selectedActivityLevel == null) {
      _showSnackBar('Please select your activity level');
      return;
    }
    if (_selectedGoal == null) {
      _showSnackBar('Please select your goal');
      return;
    }

    final weight = double.parse(_weightController.text);
    final height = double.parse(_heightController.text);
    final age = int.parse(_ageController.text);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PerfectHealthScreenResult(
          weight: weight,
          height: height,
          age: age,
          sex: _selectedSex!,
          activityLevel: _selectedActivityLevel!,
          goal: _selectedGoal!,
          activityMultipliers: activityMultipliers,
        ),
      ),
    ).then((_) {
      _weightController.clear();
      _heightController.clear();
      _ageController.clear();
      setState(() {
        _selectedSex = null;
        _selectedActivityLevel = null;
        _selectedGoal = null;
      });
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBarOfScreen(context, text: 'HealthCare Calculator'),
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
                    children: [
                      SizedBox(height: height * 0.02),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          "assets/inbodycover.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: height * 0.25,
                        ),
                      ),
                      SizedBox(height: height * 0.02),

                      DoctoryTextFormField(
                        context,
                        controller: _weightController,
                        headeroftextformfield: "Weight (kg)",
                        hinttext: "Enter your weight",
                        validationmessage: "Please enter your weight",
                        Keyboard: TextInputType.number,
                      ),
                      SizedBox(height: height * 0.02),

                      DoctoryTextFormField(
                        context,
                        controller: _heightController,
                        headeroftextformfield: "Height (cm)",
                        hinttext: "Enter your height",
                        validationmessage: "Please enter your height",
                        Keyboard: TextInputType.number,
                      ),
                      SizedBox(height: height * 0.02),

                      DoctoryTextFormField(
                        context,
                        controller: _ageController,
                        headeroftextformfield: "Age (years)",
                        hinttext: "Enter your age",
                        validationmessage: "Please enter your age",
                        Keyboard: TextInputType.number,
                      ),
                      SizedBox(height: height * 0.02),

                      buildDropdown(
                        label: "Sex",
                        value: _selectedSex,
                        items: ['Male', 'Female'],
                        onChanged: (value) => setState(() => _selectedSex = value),
                        context: context,
                        hint: 'Select your sex',
                      ),
                      SizedBox(height: height * 0.02),

                      buildDropdown(
                        label: "Activity Level",
                        value: _selectedActivityLevel,
                        items: activityMultipliers.keys.toList(),
                        onChanged: (value) =>
                            setState(() => _selectedActivityLevel = value),
                        context: context,
                        hint: 'Select your level',
                      ),
                      SizedBox(height: height * 0.02),

                      buildDropdown(
                        label: "Goal",
                        value: _selectedGoal,
                        items: goals,
                        onChanged: (value) => setState(() => _selectedGoal = value),
                        context: context,
                        hint: 'Select your goal',
                      ),
                      SizedBox(height: height * 0.03),
                    ],
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
                text: "Calculate",
                function: _onCalculate,
                textcolor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}