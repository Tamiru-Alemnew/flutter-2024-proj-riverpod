import 'package:family_cash_manager/Pages/children.dart';
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
            title: Row(
              children: const [
                Icon(Icons.home),
                SizedBox(width: 10,),
                Text('Home'),
              ],
            ),
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
            title: Row(
              children: const [
                Icon(Icons.add),
                SizedBox(width: 10,),
                Text('Add Expense'),
              ],
            
            ),
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
            title: Row(
              children: const [
                Icon(Icons.edit),
                SizedBox(width: 10,),
                Text('Edit Categories'),
              ],
            ),
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
            title: Row(
              children: const [
                Icon(Icons.people),
                SizedBox(width: 10,),
                Text('Manage Children'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const MangeChildren(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
