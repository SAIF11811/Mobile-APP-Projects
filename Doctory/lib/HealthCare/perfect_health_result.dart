import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PerfectHealthScreenResult extends StatelessWidget {
  final double weight;
  final double height;
  final int age;
  final String sex;
  final String activityLevel;
  final String goal;
  final Map<String, double> activityMultipliers;

  const PerfectHealthScreenResult({
    Key? key,
    required this.weight,
    required this.height,
    required this.age,
    required this.sex,
    required this.activityLevel,
    required this.goal,
    required this.activityMultipliers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // -------- Calculations --------
    double heightInInches = height / 2.54;
    double baseHeight = 60;
    double idealWeight = (sex == 'Male')
        ? 50 + 2.3 * (heightInInches - baseHeight)
        : 45.5 + 2.3 * (heightInInches - baseHeight);

    double bmrValue = (sex == 'Male')
        ? (10 * weight + 6.25 * height - 5 * age + 5)
        : (10 * weight + 6.25 * height - 5 * age - 161);

    double activityMultiplier = activityMultipliers[activityLevel] ?? 1.2;
    double maintenanceCalories = bmrValue * activityMultiplier;

    double caloriesEat;
    double caloriesBurn = 0;
    switch (goal) {
      case 'Lose Weight':
        caloriesEat = maintenanceCalories - 500;
        caloriesBurn = 500;
        break;
      case 'Gain Weight':
        caloriesEat = maintenanceCalories + 500;
        caloriesBurn = 0;
        break;
      default:
        caloriesEat = maintenanceCalories;
        break;
    }

    double heightInMeters = height / 100;
    double bmiValue = weight / (heightInMeters * heightInMeters);

    String bmiCategory;
    if (bmiValue < 18.5) {
      bmiCategory = 'Underweight';
    } else if (bmiValue < 25) {
      bmiCategory = 'Normal weight';
    } else if (bmiValue < 30) {
      bmiCategory = 'Overweight';
    } else {
      bmiCategory = 'Obese';
    }

    final results = '''
Health Care Results:

Weight:
${weight.toStringAsFixed(1)} kg

Height:
${height.toStringAsFixed(1)} cm

Age:
$age

Sex:
$sex

Activity Level:
$activityLevel

Goal:
$goal

Ideal Weight:
${idealWeight.toStringAsFixed(1)} kg

BMR:
${bmrValue.toStringAsFixed(1)} kcal/day

Calories to Eat:
${caloriesEat.toStringAsFixed(0)} kcal/day
${caloriesBurn > 0 ? 'Calories to Burn:\n${caloriesBurn.toStringAsFixed(0)} kcal/day\n' : ''}
BMI:
${bmiValue.toStringAsFixed(1)} ($bmiCategory)
''';

    // -------- UI --------
    return Scaffold(
      appBar: AppBarOfScreen(context, text: "Perfect Health Result"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Main Results Container
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors().secondarycolor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    results,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF2260FF),
                      fontFamily: 'Monospace',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Download Button
            SizedBox(
              width: size.width * 0.64,
              height: size.height * 0.06,
              child: ElevatedButton.icon(
                onPressed: () => _downloadPDF(context, results),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors().maincolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                icon: const FaIcon(FontAwesomeIcons.download, color: Colors.white),
                label: Text(
                  "Download",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadPDF(BuildContext context, String results) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Text(
            results,
            style: pw.TextStyle(
              fontSize: 18,
              font: pw.Font.courier(),
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
