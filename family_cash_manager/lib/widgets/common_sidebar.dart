import 'package:family_cash_manager/Pages/edit_category.dart';
import 'package:family_cash_manager/Pages/expenses.dart';
import 'package:family_cash_manager/Pages/home_page.dart';
import 'package:flutter/material.dart';

class CommonSideBar extends StatelessWidget {
  const CommonSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  builder: (BuildContext context) => const LandingPage(),
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
                  builder: (BuildContext context) => const AddExpense(),
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
                  builder: (BuildContext context) => const EditCatagoryPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Manage Children'),
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}
