import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class FindTheBallGameScreen extends StatefulWidget {
  @override
  _FindTheBallGameScreenState createState() => _FindTheBallGameScreenState();
}

class _FindTheBallGameScreenState extends State<FindTheBallGameScreen>
    with SingleTickerProviderStateMixin {
  int ballPosition = -1;
  int correctPosition = Random().nextInt(3);
  bool gameOver = false;
  bool isWin = false;

  int wins = 0;
  int losses = 0;

  late AnimationController _animationController;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _audioPlayer = AudioPlayer();
  }

  Future<void> playSound(String path) async {
    try {
      await _audioPlayer.play(AssetSource(path));
    } catch (e) {
      print('Sound error: $e');
    }
  }

  void handleGuess(int index) {
    if (gameOver) return;
    setState(() {
      ballPosition = correctPosition;
      gameOver = true;
      isWin = index == correctPosition;
      if (isWin) {
        wins++;
      } else {
        losses++;
      }
      _animationController.forward(from: 0);
    });

    playSound(isWin ? 'win.mp3' : 'lose.mp3');
  }

  void resetGame() {
    setState(() {
      correctPosition = Random().nextInt(3);
      ballPosition = -1;
      gameOver = false;
      isWin = false;
    });
  }

  Widget buildButton(int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: InkWell(
            onTap: () => handleGuess(index),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: Offset(3, 3),
                    blurRadius: 6,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-3, -3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: ballPosition == index
                    ? AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: Image.asset(
                        'assets/ball.png',
                        width: 50,
                        height: 50,
                      ),
                    );
                  },
                )
                    : Text(
                  "❓",
                  style: TextStyle(fontSize: 28, color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildScoreCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Wins: $wins',
            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            'Losses: $losses',
            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Find The Ball'),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.9,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildScoreCard(),
              Text(
                'Guess where the ball is!',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  buildButton(0),
                  buildButton(1),
                  buildButton(2),
                ],
              ),
              SizedBox(height: 30),
              if (gameOver)
                Column(
                  children: [
                    Text(
                      isWin ? 'Nice Guess 😄' : 'Try Again 👏',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isWin ? Colors.green : Colors.red,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: resetGame,
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 28,
                      ),
                      label: Text(
                        'Play Again',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}
