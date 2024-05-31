
import 'package:family_cash_manager/screens/presentations/login_page.dart';
import 'package:family_cash_manager/screens/presentations/signup.dart';
import 'package:flutter/material.dart';
import 'package:family_cash_manager/screens/presentations/budgeting_goal.dart';
import 'package:family_cash_manager/screens/presentations/children.dart';
import 'package:family_cash_manager/screens/presentations/edit_category.dart';
import 'package:family_cash_manager/screens/presentations/expenses.dart';
import 'package:family_cash_manager/screens/presentations/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/signUp': (context) => SignUp(),
        '/addExpense': (context) => EditExpensePage(),
        '/editCategories': (context) => EditCategoryPage(),
        '/manageChildren': (context) => ManageChildren(),
        '/budgetingGoal': (context) => BudgetAndGoal(),
      },
      title: 'Family Cash Manager',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
