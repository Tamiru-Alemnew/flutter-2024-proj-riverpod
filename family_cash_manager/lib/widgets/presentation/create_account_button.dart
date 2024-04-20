import 'package:family_cash_manager/screens/presentations/home_page.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomePage(),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 36, 120, 109),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Create Account',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Caros',
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
