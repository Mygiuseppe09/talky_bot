import 'package:flutter/widgets.dart';

class MyImageButton extends StatelessWidget {
  /// bottone-immaggine personalizzato
  ///
  /// la dimensione dell'immagine di default è 40x40,
  /// se ne si passa diversa, questa una verrà sovrascritta
  ///
  const MyImageButton({
    required this.pathImage, required this.onTap, this.heigt, this.width
    });

  final String pathImage;
  final void Function()? onTap;
  final double? width;
  final double? heigt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        pathImage,
        height: width ?? 40,
        width: heigt ?? 40,
      ),
    );
  }
}
