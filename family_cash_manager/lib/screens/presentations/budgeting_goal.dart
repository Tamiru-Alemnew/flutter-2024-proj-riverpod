import 'package:family_cash_manager/widgets/presentation/common_sidebar.dart';
import 'package:flutter/material.dart';

// The BudgetAndGoal class represents the main screen of the Family Cash Manager app,
// displaying the budget and goals. This class extends StatelessWidget and defines the

class BudgetAndGoal extends StatelessWidget {
  const BudgetAndGoal({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CommonSideBar(),
      appBar: AppBar(
        title: const Text('Family Cash Manager'),
      ),
      body: BudgetPage(),
    );
  }
}

/// The BudgetPage class represents the page that displays the budget details and allows
/// users to manage their finances. It extends StatefulWidget, indicating that the UI of
/// this page can change dynamically based on user interactions and state updates. The
/// class overrides the createState() method to create an instance of _BudgetPageState,
/// which manages the state of the BudgetPage.
class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

/// The _BudgetPageState class represents the state of the BudgetPage widget. It manages
/// the dynamic data and user interactions for budgeting and goal setting. This class
/// extends the State class and overrides the build() method to define the UI layout
/// and functionality of the BudgetPage. It includes sliders, input fields, and buttons
/// for managing the overall family budget, child spending limit, and specific goals.
/// The state is updated using the setState() method, reflecting changes made by the user.

class _BudgetPageState extends State<BudgetPage> {
  double overallBudget = 5000.0;
  double childSpendingLimit = 1000.0;
  Map<String, double> specificGoals = {
    'Entertainment': 1000.0,
    'Food': 1500.0,
    'Clothing': 500.0,
    'Transportation': 1000.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          'Budgeting & Goal Setting',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overall Family Budget Goal:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  '\$${overallBudget.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              ],
            ),
            Slider(
              value: overallBudget,
              min: 1000.0,
              max: 10000.0,
              activeColor: const Color.fromARGB(255, 32, 31, 31),
              onChanged: (value) {
                setState(() {
                  overallBudget = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Child Spending Limit:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  '\$${childSpendingLimit.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              ],
            ),
            Slider(
              value: childSpendingLimit,
              min: 100.0,
              max: 2000.0,
              activeColor: Colors.black,
              onChanged: (value) {
                setState(() {
                  childSpendingLimit = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Specific Goals:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: specificGoals.length,
                itemBuilder: (BuildContext context, int index) {
                  String category = specificGoals.keys.elementAt(index);
                  return _buildGoalItem(category, specificGoals[category]);
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalItem(String title, double? currentValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  specificGoals.remove(title);
                });
              },
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Text(
              '\$${currentValue?.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          ],
        ),
        Slider(
          value: currentValue ?? 0.0,
          min: 0.0,
          max: 2000.0,
          activeColor: Colors.green,
          onChanged: (value) {
            setState(() {
              specificGoals[title] = value;
            });
          },
        ),
      ],
    );
  }
}
