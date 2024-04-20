import 'package:family_cash_manager/Pages/children.dart';
import 'package:family_cash_manager/widgets/common_sidebar.dart';
import 'package:flutter/material.dart';
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
        title: Text('Landing Page'), 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddExpense()),
                );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 110,
                  width: 140,
                  padding: const EdgeInsets.all(12),
                  child: const Text(
                    "Add Expenses",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 60),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditCatagoryPage()),
                );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 110,
                  width: 140,
                  padding: const EdgeInsets.all(12),
                  child: const Text(
                    "Edit category",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 60),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MangeChildren()),
                );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 110,
                  width: 140,
                  padding: const EdgeInsets.all(12),
                  child: const Text(
                    "Manage children",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
