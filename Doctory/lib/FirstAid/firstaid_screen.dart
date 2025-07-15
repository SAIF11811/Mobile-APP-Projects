import 'package:doctory/Components/components.dart';
import 'package:doctory/GetStartedScreen/home.dart';
import 'package:flutter/material.dart';

class FirstaidScreen extends StatelessWidget {
  const FirstaidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF00368B),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Stack(
              children: [
                Image.asset('assets/images/Fir.png'),
                SizedBox(height: 15),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    size: size.height * 0.043,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          fistaidCardListView(),
        ],
      ),
    );
  }
}
