import 'package:family_cash_manager/widgets/common_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:family_cash_manager/Pages/expenses.dart';
import 'package:family_cash_manager/Pages/home_page.dart';
import 'package:family_cash_manager/Pages/edit_category.dart';

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
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      home: const HomePage(),
    );
  }
}

