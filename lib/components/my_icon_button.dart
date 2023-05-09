import 'package:flutter/material.dart';


class MyIconButton extends StatelessWidget {
  /// bottone personalizzato tondo nero con icona interna bianca
  /// 
  /// la dimensione dell'icona di default è 30, se ne si passa
  /// una verrà sovrascritta
  /// 
  const MyIconButton({required this.icon, required this.onPressed, this.size});

  final void Function()? onPressed;
  final IconData icon;
  final double? size;

  
  @override
  Widget build(BuildContext context) {
    return Container(
      // rendiamolo tondeggiante
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),

      // dimensioni
      height: 60,
      width: 60,

      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: size ?? 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
