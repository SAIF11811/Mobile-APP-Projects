import 'package:flutter/material.dart';
import 'package:news_app/emoji_match.dart';
import 'package:news_app/find_the_ball.dart';
import 'package:news_app/guess_the_number.dart';
import 'package:news_app/rock_paper_scissors.dart';

class HomeMenuScreen extends StatelessWidget {
  const HomeMenuScreen({Key? key}) : super(key: key);

  Widget buildGameButton(BuildContext context, String title, IconData icon, Widget screen) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(4, 4),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.blueAccent),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Game Zone'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.95,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Games Menu:',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              buildGameButton(context, "Rock Paper Scissors", Icons.pan_tool_alt, RockPaperScissorsGameScreen()),
              buildGameButton(context, "Find The Ball", Icons.sports_baseball, FindTheBallGameScreen()),
              buildGameButton(context, "Guess The Number", Icons.confirmation_number, GuessTheNumberGameScreen()),
              buildGameButton(context, "Match The Cards", Icons.grid_view_rounded, MatchTheCardsGameScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
