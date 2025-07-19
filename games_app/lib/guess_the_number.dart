import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class GuessTheNumberGameScreen extends StatefulWidget {
  @override
  _GuessTheNumberGameScreenState createState() => _GuessTheNumberGameScreenState();
}

class _GuessTheNumberGameScreenState extends State<GuessTheNumberGameScreen>
    with SingleTickerProviderStateMixin {
  final Random _random = Random();
  int? computerNumber;
  String? result;
  bool gameOver = false;
  int wins = 0;
  int losses = 0;
  String? userChoice;

  late AnimationController _animationController;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _audioPlayer = AudioPlayer();
  }

  Future<void> playSound(String asset) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(asset));
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  void playGame(String userGuess) {
    if (gameOver) return;

    int num = _random.nextInt(9) + 1;
    String actualCategory = num < 5 ? 'Less' : num == 5 ? 'Equal' : 'More';
    bool isWin = userGuess == actualCategory;

    setState(() {
      userChoice = userGuess;
      computerNumber = num;
      result = isWin ? 'Nice Guess 😄' : 'Sorry, Next Time 👏';
      if (isWin) {
        wins++;
        playSound('win.mp3');
      } else {
        losses++;
        playSound('lose.mp3');
      }
      gameOver = true;
    });

    _animationController.forward(from: 0);
  }

  void resetGame() {
    setState(() {
      gameOver = false;
      result = null;
      computerNumber = null;
      userChoice = null;
    });
  }

  Widget buildChoiceButton(String label, Color color, String value, double iconSize, double fontSize) {
    final isSelected = userChoice == value;

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: InkWell(
            onTap: gameOver ? null : () => playGame(value),
            borderRadius: BorderRadius.circular(24),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey.shade300 : Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade400, offset: const Offset(3, 3), blurRadius: 6),
                  const BoxShadow(color: Colors.white, offset: Offset(-3, -3), blurRadius: 6),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      value == 'Less'
                          ? Icons.arrow_downward
                          : value == 'Equal'
                          ? Icons.compare_arrows
                          : Icons.arrow_upward,
                      size: iconSize,
                      color: color,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildScoreCard(double fontSize) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Wins: $wins',
              style: TextStyle(fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold)),
          Text('Losses: $losses',
              style: TextStyle(fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget buildComputerCard(double fontSize) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade400, offset: const Offset(3, 3), blurRadius: 6),
          const BoxShadow(color: Colors.white, offset: Offset(-3, -3), blurRadius: 6),
        ],
      ),
      child: Text(
        gameOver && computerNumber != null
            ? 'Computer chose: $computerNumber'
            : 'Guess what the number is!',
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.black87),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.08;
    final fontSize = screenWidth * 0.038;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Guess The Number'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Container(
            width: screenWidth * 0.9,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 6)),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildScoreCard(fontSize),
                buildComputerCard(fontSize),
                const SizedBox(height: 30),
                Row(
                  children: [
                    buildChoiceButton('Less than 5', Colors.blue, 'Less', iconSize, fontSize),
                    buildChoiceButton('Equal to 5', Colors.amber, 'Equal', iconSize, fontSize),
                    buildChoiceButton('More than 5', Colors.red, 'More', iconSize, fontSize),
                  ],
                ),
                const SizedBox(height: 30),
                if (gameOver)
                  Column(
                    children: [
                      ScaleTransition(
                        scale: _animationController,
                        child: Text(
                          result ?? '',
                          style: TextStyle(
                            fontSize: fontSize + 2,
                            fontWeight: FontWeight.bold,
                            color: result == 'Nice Guess 😄' ? Colors.green : Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: resetGame,
                        icon: const Icon(Icons.refresh, color: Colors.white, size: 28),
                        label: Text(
                          'Play Again',
                          style: TextStyle(color: Colors.white, fontSize: fontSize),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}
