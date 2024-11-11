import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Parte superior vermelha até a metade
          Positioned.fill(
            top: 0,
            child: Container(
              color: Colors.red,
              height: MediaQuery.of(context).size.height / 2,
            ),
          ),
          
          // Parte inferior branca
          Positioned.fill(
            top: MediaQuery.of(context).size.height / 2,
            child: Container(
              color: Colors.white,
            ),
          ),
          
          // Linha preta no meio
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 2, // Ajusta para a linha ficar no meio
            left: 0,
            right: 0,
            child: Container(
              height: 4, // espessura da linha preta
              color: Colors.black,
            ),
          ),
          
          // Bola preta no centro da linha
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 25, // Ajuste para centralizar verticalmente
            left: MediaQuery.of(context).size.width / 2 - 30, // Centraliza horizontalmente
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
          ),
          
          // Bola branca sobreposta à preta
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 20, // Ajuste para centralizar verticalmente
            left: MediaQuery.of(context).size.width / 2 - 20, // Centraliza horizontalmente
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
