import 'package:flutter/material.dart';

import 'my_card.dart';
import 'my_title.dart';

class MyListTile extends StatelessWidget {
  final String imagePath, title, description;

  const MyListTile(
      {required this.imagePath,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return MyCard(
      // flutter
      child: Row(
        children: [
          Image.asset(
            fit: BoxFit.contain,
            imagePath,
            width: 80,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyTitle(text: title),
                Text(
                  description,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
