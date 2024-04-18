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
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      
      home: Scaffold(
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
        child: Text('' , style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),),
      ),
       ListTile(
              title: const Text('Home page'),
              onTap: () {
               
              },
            ),
      ListTile(
        title: const Text('Add Expense'),
        onTap: () {
         
        },
      ),
      ListTile(
        title: const Text('Edit Category'),
        onTap: () {
          
        },
      ),
     ListTile(
              title: const Text('Manage Children'),
              onTap: () {},
            ),
    ],
  ),
),
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: const Text('Family Cash Manager'),
        ),
        body: const ExpensePage(),
      ),
    );
  }
}
