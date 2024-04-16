import 'package:flutter/material.dart';
import 'package:signup/Pages/signup.dart';

void main(List<String> args) {
  runApp(const SignUpPage());
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignUp();
  }
}
