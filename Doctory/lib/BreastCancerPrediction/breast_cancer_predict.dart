import 'dart:io';
import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class BreastCancerPredictScreen extends StatefulWidget {
  const BreastCancerPredictScreen({Key? key}) : super(key: key);

  @override
  State<BreastCancerPredictScreen> createState() => _BreastCancerPredictScreenState();
}

class _BreastCancerPredictScreenState extends State<BreastCancerPredictScreen> {
  late Interpreter _interpreter;
  final picker = ImagePicker();
  File? _image;
  String _result = 'No Photos Yet';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/breast_cancer.tflite');
    } catch (e) {
      setState(() {
        _result = '❌ Failed to load model.';
      });
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _result = 'Image Selected. Ready to Predict.';
      });
    }
  }

  Future<void> captureImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _result = 'Image Captured. Ready to Predict.';
      });
    }
  }

  Future<void> predict(File imageFile) async {
    if (_interpreter == null) {
      setState(() {
        _result = '❌ Model not initialized.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _result = 'Predicting...';
    });

    try {
      final bytes = await imageFile.readAsBytes();
      img.Image? image = img.decodeImage(bytes);
      if (image == null) {
        setState(() {
          _result = '❌ Failed to decode image.';
          _isLoading = false;
        });
        return;
      }

      img.Image resized = img.copyResize(image, width: 224, height: 224);

      var input = List.generate(1, (b) => List.generate(224, (y) => List.generate(224, (x) {
        final pixel = resized.getPixel(x, y);
        return [
          pixel.r / 255.0,
          pixel.g / 255.0,
          pixel.b / 255.0,
        ];
      })));

      var output = List.filled(1 * 1, 0.0).reshape([1, 1]);

      _interpreter.run(input, output);

      double prediction = output[0] is List ? output[0][0] : output[0];

      List<String> classLabels = ['🧪 Positive', '🧬 Negative'];
      String predictedClass = classLabels[prediction > 0.5 ? 1 : 0];

      setState(() {
        _result = 'Result: $predictedClass';
      });
    } catch (e) {
      setState(() {
        _result = 'Prediction failed.';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget buildButton(String label, VoidCallback onPressed, {bool isPrimary = true}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColors().maincolor : Colors.white,
        foregroundColor: isPrimary ? Colors.white : AppColors().maincolor,
        side: isPrimary ? null : BorderSide(color: AppColors().maincolor),
        minimumSize: const Size(150, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOfScreen(context, text: 'Breast Cancer Detection'),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(_image!, height: 300),
                ),
              const SizedBox(height: 20),
              Text(
                _result,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors().maincolor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  buildButton('📁 Upload Photo', pickImageFromGallery),
                  buildButton('📸 Capture Photo', captureImage),
                  buildButton(
                    _isLoading ? '⏳ Predicting...' : '🧠 Predict',
                    (_image == null || _isLoading) ? () {} : () => predict(_image!),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}