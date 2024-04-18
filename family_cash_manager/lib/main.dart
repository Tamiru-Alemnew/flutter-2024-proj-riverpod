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

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black54,
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: Text(
                '',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text('Home page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Add Expense'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ExpensePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Edit Category'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const EditExpense(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Manage Children'),
              onTap: () {
                // Navigate to the page for managing children
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: const Text('Family Cash Manager'),
      ),
      body: const ExpensePage(),
    );
  }
}
