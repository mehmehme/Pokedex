import 'package:flutter/material.dart';

class GeometricBackground extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com formas geométricas
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade800, Colors.blue.shade300],
                ),
              ),
            ),
          ),
          // Círculos no fundo
          Positioned(
            top: -50,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple.shade300.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow.shade500.withOpacity(0.4),
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: -100,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.shade600.withOpacity(0.4),
              ),
            ),
          ),
          // Formas retangulares adicionais para dar mais camadas
          Positioned(
            top: 400,
            left: -120,
            child: Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green.shade400.withOpacity(0.3),
              ),
            ),
          ),
          // Outros elementos geométricos
          Positioned(
            top: 550,
            left: 50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(25),
                color: Colors.orange.shade500.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
