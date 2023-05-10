import 'package:flutter/material.dart';

class MyLargeElevatedButton extends StatelessWidget {
  ///
  /// shade: da 200 a 900
  ///

  const MyLargeElevatedButton({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.text,
    required this.onPressed,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            backgroundColor,
          ),
          foregroundColor: MaterialStateProperty.all(
            foregroundColor,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
