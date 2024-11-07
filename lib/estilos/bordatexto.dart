import 'package:flutter/material.dart';

class BorderedText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final double borderWidth;
  final Color borderColor;

  BorderedText({
    required this.text,
    this.textStyle = const TextStyle(fontSize: 30, color: Colors.white),
    this.borderWidth = 2.0,
    this.borderColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Texto com borda
        Text(
          text,
          style: textStyle.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = borderWidth
              ..color = borderColor, // Cor da borda
          ),
        ),
        // Texto normal
        Text(
          text,
          style: textStyle, // Cor e estilo do texto
        ),
      ],
    );
  }
}
