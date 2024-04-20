import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 36, 120, 109),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Caros',
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
