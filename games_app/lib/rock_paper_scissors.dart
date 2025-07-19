import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RockPaperScissorsGameScreen extends StatefulWidget {
  @override
  _RockPaperScissorsGameScreenState createState() =>
      _RockPaperScissorsGameScreenState();
}

class _RockPaperScissorsGameScreenState
    extends State<RockPaperScissorsGameScreen>
    with SingleTickerProviderStateMixin {
  final List<String> choices = ['Rock', 'Paper', 'Scissors'];
  String userChoice = '';
  String computerChoice = '';
  String result = '';
  int wins = 0, losses = 0, draws = 0;
  bool gameOver = false;

  late AnimationController _animationController;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
  }

  void playGame(String userPick) async {
    if (gameOver) return;

    final compPick = choices[Random().nextInt(3)];

    setState(() {
      userChoice = userPick;
      computerChoice = compPick;
      result = getResult(userPick, compPick);
      updateScore(result);
      gameOver = true;
    });

    _animationController.forward(from: 0);
    await playSound(result);
  }

  String getResult(String user, String comp) {
    if (user == comp) return 'Draw 🤝';
    if ((user == 'Rock' && comp == 'Scissors') ||
        (user == 'Paper' && comp == 'Rock') ||
        (user == 'Scissors' && comp == 'Paper')) {
      return 'Good Choice 😄';
    }
    return 'Hard Luck 👏';
  }

  void updateScore(String outcome) {
    if (outcome == 'Good Choice 😄') {
      wins++;
    } else if (outcome == 'Hard Luck 👏') {
      losses++;
    } else {
      draws++;
    }
  }

  void resetGame() {
    setState(() {
      userChoice = '';
      computerChoice = '';
      result = '';
      gameOver = false;
    });
  }

  Future<void> playSound(String outcome) async {
    String soundPath = '';
    if (outcome == 'Good Choice 😄') {
      soundPath = 'win.mp3';
    } else if (outcome == 'Hard Luck 👏') {
      soundPath = 'lose.mp3';
    } else {
      soundPath = 'draw.mp3';
    }

    try {
      await _audioPlayer.play(AssetSource(soundPath));
    } catch (e) {
      print('Sound error: $e');
    }
  }

  IconData getIcon(String choice) {
    switch (choice) {
      case 'Rock':
        return Icons.circle;
      case 'Paper':
        return Icons.description;
      case 'Scissors':
        return Icons.content_cut;
      default:
        return Icons.help_outline;
    }
  }

  Color getIconColor(String choice) {
    switch (choice) {
      case 'Rock':
        return Colors.brown;
      case 'Paper':
        return Colors.blue;
      case 'Scissors':
        return Colors.orange;
      default:
        return Colors.black;
    }
  }

  Widget buildChoiceButton(String label, IconData icon, Color color) {
    final isSelected = userChoice == label;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: InkWell(
            onTap: gameOver ? null : () => playGame(label),
            borderRadius: BorderRadius.circular(24),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey.shade300 : Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: const Offset(3, 3),
                    blurRadius: 6,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-3, -3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 40, color: color),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
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

  Widget buildScoreCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
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
          Text('Wins: $wins',
              style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
          Text('Draws: $draws',
              style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
          Text('Losses: $losses',
              style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget buildGameInfoCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(3, 3),
            blurRadius: 6,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-3, -3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        children: [
          if (!gameOver)
            const Text(
              'Make your move!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          if (gameOver && computerChoice.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Computer chose: $computerChoice',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 8),
                Icon(getIcon(computerChoice),
                    color: getIconColor(computerChoice), size: 30),
              ],
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
        title: const Text('Rock Paper Scissors'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth * 0.95,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: const [
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
                buildGameInfoCard(),
                const SizedBox(height: 24),
                Row(
                  children: [
                    buildChoiceButton('Rock', Icons.circle, Colors.brown),
                    buildChoiceButton('Paper', Icons.description, Colors.blue),
                    buildChoiceButton('Scissors', Icons.content_cut, Colors.orange),
                  ],
                ),
                const SizedBox(height: 30),
                if (result.isNotEmpty)
                  Column(
                    children: [
                      ScaleTransition(
                        scale: _animationController,
                        child: Text(
                          result,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: result == 'Good Choice 😄'
                                ? Colors.green
                                : result == 'Hard Luck 👏'
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: resetGame,
                        icon: const Icon(Icons.refresh, color: Colors.white, size: 28),
                        label: const Text(
                          'Play Again',
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
