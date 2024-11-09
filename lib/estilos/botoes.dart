import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomOutlinedButton({super.key, 
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 201, 53), 
        side: const BorderSide(color: Color.fromARGB(255, 170, 88, 12), width: 8.0), // Borda
        textStyle: const TextStyle(
          fontSize: 50.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.pressed)) {
              return const Color.fromARGB(255, 243, 145, 33).withOpacity(0.1); // Cor ao apertar
            }
            return Colors.transparent;
          },
        ),
      ),
      onPressed: onPressed,
      child: Text(text,
      style: const TextStyle(
          fontSize: 50.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 150, 74, 30),
        ),),
    );
  }
}
