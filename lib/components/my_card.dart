import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget child;

  const MyCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      elevation: 5,
      child: Padding(padding: EdgeInsets.all(10), child: child)
    );
  }
}
