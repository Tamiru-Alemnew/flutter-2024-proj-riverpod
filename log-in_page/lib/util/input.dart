import 'package:flutter/material.dart';
import 'package:login_page/util/text.dart';

class InputAccepter extends StatelessWidget {
  final String label;
  final bool obscurText;
  const InputAccepter(
      {super.key, required this.label, this.obscurText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscurText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
          label: TextWidget(
            text: label,
            color: const Color.fromARGB(255, 36, 120, 109),
            family: 'Circular Std',
            fontWeight: FontWeight.bold,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0)),
      style: const TextStyle(
        fontFamily: 'Caros',
        fontSize: 18,
      ),
    );
  }
}
