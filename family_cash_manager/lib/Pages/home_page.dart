import 'package:flutter/material.dart';
import 'package:family_cash_manager/Pages/children.dart';
import 'package:family_cash_manager/widgets/common_sidebar.dart';
import 'package:family_cash_manager/Pages/expenses.dart';
import 'package:family_cash_manager/Pages/edit_category.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CommonSideBar(),
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: const Text('Family Cash Manager'),
      ),
      body: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCard(
              context,
              "Add Expenses",
              AddExpense(),
              Icons.attach_money,
            ),
            SizedBox(height: 40),
            _buildCard(
              context,
              "Edit Category",
              EditCatagoryPage(),
              Icons.category,
            ),
            SizedBox(height: 40),
            _buildCard(
              context,
              "Manage Children",
              MangeChildren(),
              Icons.child_care,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, String title, Widget page, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          alignment: Alignment.center,
          height: 140,
          width: 160,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: 50,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
