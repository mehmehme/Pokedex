import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Cria o gradiente radial centralizado, do azul claro ao azul escuro
    final radialGradient = RadialGradient(
      colors: [
        Colors.blue.shade200,
        Colors.blue.shade700,
        Colors.blue.shade900,
      ],
      stops: [0.3, 0.7, 1.0],
      center: Alignment.center,
      radius: 1.0,
    );

    final paint = Paint()..shader = radialGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Desenha o retângulo do fundo com o gradiente
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Cria círculos adicionais para dar o efeito de 'zoom'
    final circlePaint = Paint()..color = Colors.white.withOpacity(0.1);
    const circleOffsets = [
      Offset(0.3, 0.3),
      Offset(0.7, 0.3),
      Offset(0.5, 0.5),
      Offset(0.3, 0.7),
      Offset(0.7, 0.7),
    ];

    for (var offset in circleOffsets) {
      canvas.drawCircle(
        Offset(size.width * offset.dx, size.height * offset.dy),
        size.width * 0.15,
        circlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Background extends StatelessWidget {
  final Widget child;

  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: CustomPaint(
            painter: BackgroundPainter(),
          ),
        ),
        child, // Adiciona o conteúdo da tela sobre o fundo
      ],
    );
  }
}
