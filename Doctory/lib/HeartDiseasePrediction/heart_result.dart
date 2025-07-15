import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HeartPredict extends StatefulWidget {
  final List<dynamic> inputs;

  HeartPredict({required this.inputs});

  @override
  _HeartPredictState createState() => _HeartPredictState();
}

class _HeartPredictState extends State<HeartPredict> {
  String result = "Awaiting prediction...";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    predictHeartDisease();
  }

  Future<void> predictHeartDisease() async {
    final url = Uri.parse("https://doctory-5042f7a2bffd.herokuapp.com/predict_heart_disease");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"input": widget.inputs}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          result = data['prediction'];
          isLoading = false;
        });
      } else {
        setState(() {
          result = "Error: ${response.body}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        result = "Failed to connect to server: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isAbnormal = result == "Your results are not normal :(";
    final path = isAbnormal ? 'assets/heartsad.png' : 'assets/hearthappy.png';

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
                    maxWidth: size.width * 0.9,
                    minWidth: size.width * 0.6,
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
              isAbnormal ? _buildAbnormalSection(textTheme) : _buildNormalSection(textTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAbnormalSection(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader("Diagnosis:", textTheme),
        _buildParagraph("You may have a heart disease.", textTheme),
        const SizedBox(height: 10),
        _buildHeader("Next Steps:", textTheme),
        _buildBulletList([
          "Consult a cardiologist.",
          "Avoid heavy physical exertion.",
          "Eat low-fat, heart-healthy meals.",
          "Take prescribed medications regularly.",
        ], textTheme),
      ],
    );
  }

  Widget _buildNormalSection(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader("Diagnosis:", textTheme),
        _buildParagraph("You do not have heart disease.", textTheme),
        const SizedBox(height: 10),
        _buildHeader("Health Tips:", textTheme),
        _buildBulletList([
          "Exercise regularly.",
          "Eat low-cholesterol meals.",
          "Avoid smoking and stress.",
          "Go for regular checkups.",
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

  Widget _buildBulletList(List<String> tips, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tips.map((tip) {
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
                  tip,
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
