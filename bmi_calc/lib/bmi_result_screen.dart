import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget
{
  final int result;
  final bool isMale;
  final int age;

  BMIResultScreen({
    required this.result,
    required this.age,
    required this.isMale,
  });

  String getResults() {
    return '''
    BMI TEST              
-----------------
Gender: ${isMale ? 'Male' : 'Female'}
Result: $result
Age: $age
''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          'BMI CALCULATOR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: Text(
              getResults(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Monospace',
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}