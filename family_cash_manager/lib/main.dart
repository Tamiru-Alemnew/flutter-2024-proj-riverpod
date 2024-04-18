import 'package:flutter/material.dart';
import 'package:family_cash_manager/Pages/expenses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Cash Manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
      ),
      home: const ExpensePage(),
    );
  }
}
