import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

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
        title: Text('Budgeting & Goal Setting'),
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
                  onPressed: () {
                    // Add functionality to edit overall budget goal
                  },
                ),
              ],
            ),
            Slider(
              value: overallBudget,
              min: 1000.0,
              max: 10000.0,
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
                  onPressed: () {
                    // Add functionality to edit child spending limit
                  },
                ),
              ],
            ),
            Slider(
              value: childSpendingLimit,
              min: 100.0,
              max: 2000.0,
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
              onPressed: () {
                // Add functionality to save budget goals and spending limits
              },
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
        Text(
          title,
          style: TextStyle(fontSize: 16),
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
              onPressed: () {

              },
            ),
          ],
        ),
        Slider(
          value: currentValue ?? 0.0,
          min: 0.0,
          max: 2000.0,
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
