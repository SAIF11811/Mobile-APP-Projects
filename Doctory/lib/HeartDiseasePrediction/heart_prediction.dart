import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:doctory/HeartDiseasePrediction/heart_result.dart';
import 'package:flutter/material.dart';

class HeartDiseaseScreen extends StatefulWidget {
  const HeartDiseaseScreen({super.key});

  @override
  _HeartDiseaseScreenState createState() => _HeartDiseaseScreenState();
}

class _HeartDiseaseScreenState extends State<HeartDiseaseScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<String> data = [
    'age', 'sex', 'cp', 'trestbps', 'chol', 'fbs', 'restecg', 'thalach',
    'exang', 'oldpeak', 'slope', 'ca', 'thal'
  ];

  late List<dynamic> inputs;
  late List<TextEditingController> controllers;
  int? sexValue;

  @override
  void initState() {
    super.initState();
    inputs = List.filled(data.length, 0);
    controllers = List.generate(data.length, (_) => TextEditingController());
  }

  void updateInput(int index, dynamic value) {
    setState(() {
      inputs[index] = value;
    });
  }

  void resetInputs() {
    setState(() {
      for (int i = 0; i < inputs.length; i++) {
        if (data[i] != 'sex') {
          controllers[i].clear();
        }
      }
      sexValue = null;
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
    if (data[index] == 'sex') {
      return buildDropdown(
        context: context,
        label: 'Sex',
        value: sexValue == null ? null : (sexValue == 1 ? 'Male' : 'Female'),
        items: ['Male', 'Female'],
        onChanged: (value) {
          setState(() {
            sexValue = value == 'Male' ? 1 : 0;
            updateInput(index, sexValue);
          });
        },
        hint: 'Select your sex',
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.01),
        child: DoctoryTextFormField(
          context,
          controller: controllers[index],
          headeroftextformfield: data[index],
          hinttext: 'Enter ${data[index]}',
          validationmessage: 'Please enter ${data[index]}',
          Keyboard: TextInputType.number,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBarOfScreen(context, text: 'Heart Disease Prediction'),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable form inputs
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

            // Fixed bottom button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.02,
              ),
              child: DoctoryButton(
                context,
                color: AppColors().maincolor,
                text: "Predict",
                function: () {
                  if (_formKey.currentState!.validate()) {
                    for (int i = 0; i < data.length; i++) {
                      if (data[i] != 'sex') {
                        inputs[i] = double.tryParse(controllers[i].text) ?? 0;
                      } else {
                        inputs[i] = sexValue ?? 0;
                      }
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HeartPredict(inputs: inputs),
                      ),
                    ).then((_) => resetInputs());
                  }
                },
                textcolor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}