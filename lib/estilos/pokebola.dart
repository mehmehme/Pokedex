import 'package:flutter/material.dart';

class Fundopoke extends StatelessWidget {
  const Fundopoke({super.key});

  @override
  Widget build(BuildContext context) {
    double circleHeight = MediaQuery.of(context).size.height * 0.8;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView( 
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 500.0), 
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 100.0),
                      Align(
                        alignment: Alignment.center,
                        child: Transform.translate(
                          offset: Offset(0, -circleHeight / 8), // Subindo a metade inferior
                          child: Container(
                            width: circleHeight,
                            height: circleHeight / 4,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 167, 57, 57),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(circleHeight / 2.3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Linha preta
                  Column(
                    children: [
                      const SizedBox(height: 165.0),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  // Bola branca do centro
                  Column(
                    children: [
                      const SizedBox(height: 140.0),
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 8),
                          ),
                          child: Center(
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 0, 0, 0),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Círculo inferior (metade branca da Pokébola)
                  Column(
                    children: [
                      const SizedBox(height: 380.0),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Transform.translate(
                          offset: Offset(0, -circleHeight / 4.2), // Subindo a metade inferior
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.25  ,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(circleHeight / 2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
