import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ExpensePage(),
    );
  }
}

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key});


  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<Expense> expenses = [];
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
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
            ElevatedButton(
              onPressed: () {
                setState(() {
                  expenses.add(Expense(
                    category: DropdownMenus.dropdownValue,
                    amount: 100,
                    date: _selectedDate ?? DateTime.now(),
                  ));
                });
              },
              child: Text('Add Expense'),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Expenses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}

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

class DateSelector extends StatefulWidget {
  const DateSelector({Key? key});

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: Text(
            _selectedDate == null
                ? 'Select Date'
                : 'Selected Date: ${_selectedDate!.toString().split(' ')[0]}',
          ),
        ),
      ],
    );
  }
}


