import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MatchTheCardsGameScreen extends StatefulWidget {
  const MatchTheCardsGameScreen({Key? key}) : super(key: key);

  @override
  State<MatchTheCardsGameScreen> createState() => _MatchTheCardsGameScreenState();
}

class _MatchTheCardsGameScreenState extends State<MatchTheCardsGameScreen> {
  final List<String> emojis = [
    "🍎", "🐶", "🚗", "🎈", "🌟", "🍕",
    "🐱", "⚽", "🎮", "🍩", "📚", "🎵"
  ];

  late List<_CardModel> cards;
  _CardModel? firstCard;
  _CardModel? secondCard;
  bool allowFlip = true;
  bool isPaused = false;
  bool hasStarted = false;
  int matchedPairs = 0;
  int seconds = 0;
  Timer? timer;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _playSound(String path) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(path));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  void _startNewGame() {
    List<String> allEmojis = [...emojis, ...emojis];
    allEmojis.shuffle(Random());
    cards = List<_CardModel>.generate(
      allEmojis.length,
          (index) => _CardModel(id: index, emoji: allEmojis[index]),
    );
    matchedPairs = 0;
    firstCard = null;
    secondCard = null;
    allowFlip = true;
    isPaused = false;
    seconds = 0;
    hasStarted = true;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => seconds++);
    });

    setState(() {});
  }

  void _togglePause() {
    setState(() {
      if (isPaused) {
        timer = Timer.periodic(const Duration(seconds: 1), (_) {
          setState(() => seconds++);
        });
      } else {
        timer?.cancel();
      }
      isPaused = !isPaused;
    });
  }

  void _flipCard(_CardModel card) async {
    if (!allowFlip || isPaused || card.isMatched) return;
    if (card.isFlipped && firstCard == card && secondCard == null) {
      setState(() {
        card.isFlipped = false;
        firstCard = null;
      });
      return;
    }
    if (card.isFlipped) return;

    await _playSound('pop.mp3');

    setState(() => card.isFlipped = true);

    if (firstCard == null) {
      firstCard = card;
    } else {
      secondCard = card;
      allowFlip = false;

      await Future.delayed(const Duration(milliseconds: 500));

      if (firstCard!.emoji == secondCard!.emoji) {
        setState(() {
          firstCard!.isMatched = true;
          secondCard!.isMatched = true;
          matchedPairs++;
        });
      } else {
        setState(() {
          firstCard!.isFlipped = false;
          secondCard!.isFlipped = false;
        });
      }

      firstCard = null;
      secondCard = null;
      allowFlip = true;

      if (matchedPairs == emojis.length) {
        timer?.cancel();
        await _playSound('win.mp3');
        _showWinDialog();
      }
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('🎉 Congratulations!',
            style: TextStyle(color: Colors.blueAccent, fontSize: 24)),
        content: Text('Time: ${_formatTime(seconds)}',
            style: const TextStyle(fontSize: 20)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _startNewGame();
            },
            child: const Text('Play Again',
                style: TextStyle(color: Colors.blueAccent, fontSize: 20)),
          ),
        ],
      ),
    );
  }

  String _formatTime(int totalSeconds) {
    final hours = (totalSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((totalSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$secs";
  }

  Widget buildCard(_CardModel card, double fontSize) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () => _flipCard(card),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: card.isFlipped || card.isMatched ? 1 : 0),
          duration: const Duration(milliseconds: 400),
          builder: (context, value, child) {
            final isFront = value >= 0.5;

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(pi * value),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  child: Text(
                    isFront ? card.emoji : "❓",
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildTimerControls() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
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
          child: Text(
            '⏱️ Time: ${_formatTime(seconds)}',
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _togglePause,
              style: ElevatedButton.styleFrom(
                backgroundColor: isPaused ? Colors.green : Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: Icon(
                isPaused ? Icons.play_arrow : Icons.pause,
                color: Colors.white,
                size: 20,
              ),
              label: Text(
                isPaused ? "Resume" : "Pause",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: _startNewGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.refresh, color: Colors.white, size: 20),
              label: const Text("Restart",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final cardSize = isTablet ? screenWidth * 0.14 : screenWidth * 0.18;
    final fontSize = isTablet ? 32.0 : 24.0;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Match The Card'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth * 0.9,
            padding: const EdgeInsets.all(24),
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
                if (!hasStarted) ...[
                  ElevatedButton.icon(
                    onPressed: _startNewGame,
                    icon: const Icon(Icons.play_arrow, size: 26, color: Colors.white),
                    label: const Text("Start Game",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ],
                if (hasStarted) ...[
                  buildTimerControls(),
                  const SizedBox(height: 15),
                  Text(
                    'Match all the emoji pairs!',
                    style: TextStyle(
                      fontSize: screenWidth * 0.055,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = (constraints.maxWidth ~/ cardSize).clamp(3, 6);
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cards.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) =>
                            buildCard(cards[index], fontSize),
                      );
                    },
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}

class _CardModel {
  final int id;
  final String emoji;
  bool isFlipped = false;
  bool isMatched = false;

  _CardModel({required this.id, required this.emoji});
}
