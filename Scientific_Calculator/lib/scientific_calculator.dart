import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:math_expressions/math_expressions.dart' hide Stack;
import 'package:clipboard/clipboard.dart';

class ScientificCalculatorScreen extends StatefulWidget {
  const ScientificCalculatorScreen({super.key});

  @override
  State<ScientificCalculatorScreen> createState() =>
      _ScientificCalculatorScreenState();
}

class _ScientificCalculatorScreenState
    extends State<ScientificCalculatorScreen> {
  String _expression = '';
  String _result = '0';
  bool isSecondFunction = false;
  bool isDegree = true;

  final List<String> mainButtons = [
    '1ˢᵗ', 'π', 'e', 'C', '⌫',
    'sin', 'cos', 'tan', '%', 'DEG',
    '|x|', '(', ')', 'n!', '×',
    '√', '7', '8', '9', '−',
    'x²', '4', '5', '6', '+',
    'xʸ', '1', '2', '3', '÷',
    '10ˣ', '±', '0', '.', '=',
  ];

  final List<String> secondLayer = [
    '', '', '', '', '',
    'sin⁻¹', 'cos⁻¹', 'tan⁻¹', '', '',
    '1/x', '', '', '', '',
    '∛', '', '', '', '',
    'x³', '', '', '', '',
    'y√x', '', '', '', '',
    '2ˣ', '', '', '', '',
  ];

  void _triggerHaptic() {
    HapticFeedback.selectionClick();
  }

  void _onButtonPressed(String text) {
    _triggerHaptic();
    setState(() {
      switch (text) {
        case '1ˢᵗ':
        case '2ⁿᵈ':
          isSecondFunction = !isSecondFunction;
          break;
        case 'DEG':
        case 'RAD':
          isDegree = !isDegree;
          break;
        case 'C':
          _expression = '';
          _result = '0';
          break;
        case '⌫':
          if (_expression.isNotEmpty) {
            _expression = _expression.substring(0, _expression.length - 1);
          }
          break;
        case '=':
          _calculateResult();
          break;
        case 'π':
          _expression += pi.toString();
          break;
        case 'e':
          _expression += e.toString();
          break;
        case 'x²':
          _expression += '^2';
          break;
        case 'x³':
          _expression += '^3';
          break;
        case '1/x':
          _expression = '1/($_expression)';
          break;
        case '|x|':
          _expression = 'abs($_expression)';
          break;
        case '%':
          _expression += '/100';
          break;
        case '√':
          _expression = 'sqrt($_expression)';
          break;
        case '∛':
          _expression = '($_expression)^(1/3)';
          break;
        case 'y√x':
          _expression = '($_expression)^(1/x)';
          break;
        case 'n!':
          try {
            int n = int.parse(_expression);
            int fact = 1;
            for (int i = 1; i <= n; i++) fact *= i;
            _expression = fact.toString();
          } catch (_) {
            _expression = 'Error';
          }
          break;
        case 'xʸ':
          _expression += '^';
          break;
        case '10ˣ':
          _expression = '10^($_expression)';
          break;
        case '2ˣ':
          _expression = '2^($_expression)';
          break;
        case 'sin':
        case 'cos':
        case 'tan':
        case 'asin':
        case 'acos':
        case 'atan':
          _expression += '$text(';
          break;
        case 'sin⁻¹':
          _expression += 'asin(';
          break;
        case 'cos⁻¹':
          _expression += 'acos(';
          break;
        case 'tan⁻¹':
          _expression += 'atan(';
          break;
        case '±':
          if (_expression.isNotEmpty && !_expression.startsWith('-')) {
            _expression = '-($_expression)';
          } else {
            _expression =
                _expression.replaceFirst(RegExp(r'^-\((.*)\)$'), r'\1');
          }
          break;
        default:
          _expression += text;
      }
    });
  }

  void _calculateResult() {
    try {
      String expr = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('−', '-')
          .replaceAll('%', 'mod')
          .replaceAllMapped(RegExp(r'(\d+)!'), (match) {
        int n = int.parse(match.group(1)!);
        int fact = 1;
        for (int i = 1; i <= n; i++) fact *= i;
        return fact.toString();
      });

      Parser parser = Parser();
      Expression exp = parser.parse(expr);
      ContextModel cm = ContextModel();

      double eval = exp.evaluate(EvaluationType.REAL, cm);

      if (eval == eval.toInt()) {
        _result = eval.toInt().toString();
      } else {
        _result = eval.toString().replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');
      }
    } catch (_) {
      _result = 'Error';
    }
  }

  void _copyResult() {
    FlutterClipboard.copy(_result).then((_) {
      Fluttertoast.showToast(
        msg: "Result copied to clipboard",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    });
  }

  Widget buildCalculatorButton(String label, Color bgColor, double fontSize) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _onButtonPressed(label),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [bgColor.withOpacity(0.95), bgColor.withOpacity(0.65)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 4,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 6,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF121212), Color(0xFF1D1D35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: size.height * 0.2,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: GestureDetector(
                onLongPress: _copyResult,
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          _expression,
                          style: TextStyle(
                            fontSize: size.width * 0.08,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Text(
                        _result,
                        key: ValueKey(_result),
                        style: TextStyle(
                          fontSize: size.width * 0.1,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: mainButtons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.15,
                ),
                itemBuilder: (context, index) {
                  final baseLabel = mainButtons[index];
                  final secondLabel = secondLayer[index];
                  final showSecond =
                      isSecondFunction && secondLabel.isNotEmpty;

                  String label;
                  if (baseLabel == '1ˢᵗ') {
                    label = isSecondFunction ? '2ⁿᵈ' : '1ˢᵗ';
                  } else {
                    label = showSecond ? secondLabel : baseLabel;
                  }

                  if (label == 'DEG' || label == 'RAD') {
                    label = isDegree ? 'DEG' : 'RAD';
                  }

                  Color bgColor = Colors.grey.shade900;

                  return buildCalculatorButton(
                      label, bgColor, size.width * 0.06);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
