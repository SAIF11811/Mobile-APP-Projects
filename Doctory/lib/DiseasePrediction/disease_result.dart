import 'dart:convert';
import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictResult extends StatefulWidget {
  final List<String> selectedSymptoms;

  const PredictResult({Key? key, required this.selectedSymptoms}) : super(key: key);

  @override
  _PredictResultState createState() => _PredictResultState();
}

class _PredictResultState extends State<PredictResult> {
  String? disease;
  String? description;
  List<String>? precautions;
  bool isLoading = true;
  bool hasError = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchPrediction();
  }

  Future<void> fetchPrediction() async {
    setState(() {
      isLoading = true;
      hasError = false;
      errorMessage = null;
    });

    final url = Uri.parse("https://doctory-5042f7a2bffd.herokuapp.com/predict_disease");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"symptoms": widget.selectedSymptoms}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          disease = data["disease"];
          description = data["description"];
          precautions = List<String>.from(data["precautions"]);
          isLoading = false;
        });
      } else {
        handleError(response.statusCode, response.body);
      }
    } catch (e) {
      handleError(null, e.toString());
    }
  }

  void handleError(int? statusCode, String message) {
    setState(() {
      hasError = true;
      isLoading = false;
      errorMessage = statusCode != null
          ? "Server Error: $statusCode, $message"
          : "Error: $message";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOfScreen(context, text: "Predict Result"),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : hasError
            ? ErrorDisplay(message: errorMessage, onRetry: fetchPrediction)
            : PredictionDisplay(
          disease: disease,
          description: description,
          precautions: precautions,
        ),
      ),
    );
  }
}

class ErrorDisplay extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;

  const ErrorDisplay({Key? key, required this.message, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, color: Colors.red, size: 50),
        SizedBox(height: 10),
        Text(message ?? "Failed to fetch prediction. Please try again."),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: onRetry,
          child: Text("Retry"),
        ),
      ],
    );
  }
}

class PredictionDisplay extends StatelessWidget {
  final String? disease;
  final String? description;
  final List<String>? precautions;

  const PredictionDisplay({
    Key? key,
    required this.disease,
    required this.description,
    required this.precautions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Column(
              children: [
                Center(
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: 100,
                      maxWidth: size.width * 0.85,
                      minHeight: 50,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors().maincolor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        disease ?? "Disease Name",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                Image.asset(
                  'assets/predictdiseaseImage1.png',
                  fit: BoxFit.cover,
                  height: size.height * 0.3,
                  width: double.infinity,
                ),
              ],
            ),
          ),

          SizedBox(
            height: 5,
            width: double.infinity,
            child: Container(color: AppColors().maincolor),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description:",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: AppColors().maincolor, fontWeight: FontWeight.bold),
                ),
                Text(
                  description ?? "No description available",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 16),
                Text(
                  "Precautions:",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: AppColors().maincolor, fontWeight: FontWeight.bold),
                ),
                precautions != null && precautions!.isNotEmpty
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: precautions!
                      .map(
                        (precaution) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Text(
                                "•",
                                style: TextStyle(
                                  color: AppColors().maincolor,
                                  fontSize: (Theme.of(context).textTheme.titleLarge?.fontSize ?? 16) + 4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: " $precaution",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      .toList(),
                )
                    : Text(
                  "No precautions available",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
