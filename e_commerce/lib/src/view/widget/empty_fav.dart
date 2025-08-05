import 'package:flutter/material.dart';

class EmptyFav extends StatelessWidget {
  const EmptyFav({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.asset('assets/images/empty_fav.png'),
          ),
        ),
        const Text(
          "Empty Favorite",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )
      ],
    );
  }
}
