import 'package:family_cash_manager/widgets/presentation/common_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:family_cash_manager/widgets/presentation/drop_down.dart';
import 'package:family_cash_manager/widgets/presentation/date_selector.dart';
import 'package:flutter/widgets.dart';

/// The AddExpense class represents the page for adding a new expense in the Family Cash Manager app.
/// This class extends StatelessWidget and defines the UI layout using Scaffold. It includes a drawer for
/// navigation and an app bar with the app title. The body of the page is populated with the ExpensePage widget,
/// which contains the form and controls for adding a new expense.

class AddExpense extends StatelessWidget {
  const AddExpense({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CommonSideBar(),
      appBar: AppBar(
        title: const Text('Family Cash Manager'),
      ),
      body: const ExpensePage(),
    );
  }
}

/// The ExpensePage class represents the page for managing expenses in the Family Cash Manager app.
/// It extends StatefulWidget, indicating that the UI of this page can change dynamically based on user interactions
/// and state updates. The class overrides the createState() method to create an instance of _ExpensePageState,
/// which manages the state of the ExpensePage.

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key});

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

/// The _ExpensePageState class represents the state of the ExpensePage in the Family Cash Manager app.
/// It manages the dynamic data and user interactions for adding and displaying expenses.
/// This class extends the State class and overrides the build() method to define the UI layout and functionality
/// of the ExpensePage. It includes form elements for entering the category, amount, and date of an expense,
/// as well as a button to add the expense. The state is updated using the setState() method, reflecting changes
/// made by the user. The list of expenses is displayed in a DataTable widget, showing the category, amount, and date
/// of each expense.

class _ExpensePageState extends State<ExpensePage> {
  List<Expense> expenses = [];
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          'Add Expenses',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownMenus(),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Amount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter amount',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DateSelector(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
                    alignment: Alignment.center,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 36, 120, 109))),
                onPressed: () {
                  setState(() {
                    expenses.add(Expense(
                      category: DropdownMenus.dropdownValue,
                      amount: 100,
                      date: _selectedDate ?? DateTime.now(),
                    ));
                  });
                },
                child: Text(
                  'Add Expense',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Expenses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.green[300]!),
                  columns: const [
                    DataColumn(
                        label: Text('Category',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Amount',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Date',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: expenses.map((expense) {
                    return DataRow(
                      cells: [
                        DataCell(Text(expense.category)),
                        DataCell(Text(expense.amount.toString())),
                        DataCell(Text(expense.date.toString())),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The Expense class represents an expense in the Family Cash Manager app.
/// It encapsulates the properties of an expense, including the category, amount, and date.
/// The category represents the type or category of the expense, such as "Food" or "Transport".
/// The amount represents the monetary value of the expense.
/// The date represents the date and time when the expense was recorded.
///
/// The properties of an expense are final and must be provided when creating a new instance of the Expense class.
/// Once created, the expense object is immutable and its properties cannot be modified.

class Expense {
  final String category;
  final double amount;
  final DateTime date;

  Expense({
    required this.category,
    required this.amount,
    required this.date,
  });
}
