import 'package:flutter/material.dart';

class MySlider extends StatelessWidget {
  final IconData icon;
  final String title, subtitle, displayedValue;
  final double value, min, max;
  final void Function(double)? onChanged;

  const MySlider({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.displayedValue,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // blocco volume
      children: [
        ListTile(
          leading: Icon(icon, size: 60),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Text(displayedValue),
        ),
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Slider(
            thumbColor: Colors.black, // colore pallino
            activeColor: Colors.black, // colore parte piena
            inactiveColor: Colors.grey.shade300, // colore parte mancante
            min: min,
            max: max,
            value: value,
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}
