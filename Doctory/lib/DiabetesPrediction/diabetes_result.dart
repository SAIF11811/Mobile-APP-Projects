import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiabetesResult extends StatefulWidget {
  final dynamic inputs;

  DiabetesResult({required this.inputs});

  @override
  _DiabetesResultState createState() => _DiabetesResultState();
}

class _DiabetesResultState extends State<DiabetesResult> {
  String result = "Awaiting prediction...";
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchDiabetesPrediction();
  }

  Future<void> fetchDiabetesPrediction() async {
    final url = Uri.parse("https://doctory-5042f7a2bffd.herokuapp.com/predict_diabetes");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(widget.inputs),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          result = data['prediction'];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Error: ${response.statusCode} ${response.reasonPhrase}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Failed to connect to server: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isDiabetic = result == "Diabetic :(";
    final path = isDiabetic ? 'assets/diabetessad.png' : 'assets/diabeteshappy.png';

    return Scaffold(
      appBar: AppBarOfScreen(context, text: 'Predict Result'),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 60,
                    minWidth: size.width * 0.5,
                    maxWidth: size.width * 0.85,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors().maincolor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      result,
                      style: textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Image.asset(path, width: size.width * 0.7),
              const SizedBox(height: 10),
              Divider(thickness: 4, color: AppColors().maincolor),
              const SizedBox(height: 20),
              isDiabetic ? _buildDiabeticSection(textTheme) : _buildNonDiabeticSection(textTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiabeticSection(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader("Diagnosis:", textTheme),
        _buildParagraph("Your blood sugar level indicates a diabetic condition.", textTheme),
        const SizedBox(height: 10),
        _buildHeader("Next Steps:", textTheme),
        _buildBulletList([
          "Consult your doctor for diagnosis and treatment.",
          "Monitor your blood sugar regularly.",
          "Maintain a healthy diet and lifestyle.",
          "Take medications as prescribed.",
        ], textTheme),
      ],
    );
  }

  Widget _buildNonDiabeticSection(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader("Diagnosis:", textTheme),
        _buildParagraph("Your blood sugar level is within the normal range. You are not diabetic.", textTheme),
        const SizedBox(height: 10),
        _buildHeader("Health Tips:", textTheme),
        _buildBulletList([
          "Maintain a balanced diet to keep blood sugar stable.",
          "Monitor your blood sugar occasionally, especially if you're at risk.",
          "Avoid excessive sugar intake and processed foods.",
        ], textTheme),
      ],
    );
  }

  Widget _buildHeader(String title, TextTheme textTheme) {
    return Text(
      title,
      style: textTheme.headlineMedium?.copyWith(
        color: AppColors().maincolor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildParagraph(String text, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: textTheme.titleLarge,
      ),
    );
  }

  Widget _buildBulletList(List<String> items, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((text) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "• ",
                style: TextStyle(
                  fontSize: (textTheme.titleLarge?.fontSize ?? 16) + 2,
                  color: AppColors().maincolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: textTheme.titleLarge,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
