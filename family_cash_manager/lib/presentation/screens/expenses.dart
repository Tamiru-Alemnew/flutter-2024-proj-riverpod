import 'package:family_cash_manager/application/providers/expense_provider.dart';
import 'package:family_cash_manager/application/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:family_cash_manager/application/providers/category_provider.dart';
import 'package:flutter/material.dart';

class EditExpensePage extends ConsumerWidget {
  const EditExpensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Cash Manager'),
      ),
      body: ExpensePage(),
    );
  }
}


class ExpensePage extends ConsumerWidget {
  ExpensePage({Key? key}) : super(key: key);

  final TextEditingController amountController = TextEditingController();
  String? _selectedCategory;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseState = ref.watch(expenseProvider);
    final categoryState = ref.watch(categoryProvider);

    if (expenseState is ExpenseError) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(expenseState.error)),
        );
      });
    }

    if (expenseState is ExpenseLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (expenseState is ExpenseLoaded) {
      final expenses = expenseState.expenses;

      if (categoryState is CategoryLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (categoryState is CategoryLoaded) {
        if (_selectedCategory == null && categoryState.categories.isNotEmpty) {
          final idd = categoryState.categories[0]["id"];
          _selectedCategory = categoryState.categories[0][idd];
        }

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
                Consumer(builder: (context, WidgetRef ref, child) {
                  final categoryState = ref.watch(categoryProvider);
                  if (categoryState is CategoryLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (categoryState is CategoryLoaded) {
                    if (_selectedCategory == null &&
                        categoryState.categories.isNotEmpty) {
                      final idd = categoryState.categories[0]["id"];
                      _selectedCategory = categoryState.categories[0][idd];
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        DropdownButton<String>(
                          value: _selectedCategory,
                          hint: Text('Select Category'),
                          items: categoryState.categories.map((category) {
                            return DropdownMenuItem<String>(
                              value: category[category["id"]],
                              child: Text(category[category["id"]]),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            _selectedCategory = newValue;
                          },
                        ),
                      ],
                    );
                  } else {
                    return Text('Failed to load categories');
                  }
                }),
                SizedBox(height: 20),
                Text(
                  'Amount',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: amountController,
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
                DateSelector(
                  onDateSelected: (DateTime date) {
                    _selectedDate = date;
                  },
                ),
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
                          const Color.fromARGB(255, 36, 120, 109)),
                    ),
                    onPressed: () {
                      if (amountController.text.isNotEmpty &&
                          _selectedCategory != null) {
                        final userState = ref.watch(userProvider);
                        if (userState is UserAuthenticated) {
                          final userId = userState.user.userId;
                          ref.read(expenseProvider.notifier).addExpense(
                                userId,
                                _selectedCategory!,
                                amountController.text,
                                _selectedDate?.toString() ??
                                    DateTime.now().toString(),
                              );
                        }
                        amountController.clear();
                        _selectedDate = null;
                        _selectedCategory = null;
                      }
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
                Consumer(builder: (context, WidgetRef ref, child) {
                  final expenseState = ref.watch(expenseProvider);

                  return Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.green[300]!),
                          columns: const [
                            DataColumn(
                                label: Text('Category',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Amount',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Date',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Actions',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ],
                          rows: expenses.map((expense) {
                            return DataRow(
                              cells: [
                                DataCell(Text(expense['category'])),
                                DataCell(Text(expense['amount'].toString())),
                                DataCell(Text(
                                    expense['date'].toString().split(' ')[0])),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        TextEditingController
                                            editCategoryController =
                                            TextEditingController(
                                                text: expense['category']);
                                        TextEditingController
                                            editAmountController =
                                            TextEditingController(
                                                text:
                                                    expense["amount"].toString());
                                        
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Edit Expense'),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  TextField(
                                                    controller:
                                                        editCategoryController,
                                                    decoration: InputDecoration(
                                                        labelText: 'Category'),
                                                  ),
                                                  TextField(
                                                    controller:
                                                        editAmountController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        labelText: 'Amount'),
                                                  ),
                                                  DateSelector(
                                                    onDateSelected:
                                                        (DateTime date) {
                                                      expense.date = date;
                                                    },
                                                  ),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                    child: Text('Save'),
                                                    onPressed: () {
                                                      final userState = ref
                                                          .watch(userProvider);
                                                      if (userState
                                                          is UserAuthenticated) {
                                                        final userId = userState
                                                            .user.userId;
                                                        ref
                                                            .read(
                                                                expenseProvider
                                                                    .notifier)
                                                            .updateExpense(
                                                             expense['id'],
                                                              userId,
                                                              editCategoryController
                                                                  .text,
                                                              editAmountController
                                                                  .text,
                                                              expense['date']
                                                                  .toString(),
                                                            );
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    }),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        ref
                                            .read(expenseProvider.notifier)
                                            .deleteExpense(expense['id']);
                                      },
                                    ),
                                  ],
                                )),
                              ],
                            );
                          }).toList()),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      } else if (categoryState is CategoryError) {
        return Text('Failed to load categories');
      }
    } else if (expenseState is ExpenseError) {
      return Text(expenseState.error);
    }

    return Container(); // Fallback in case none of the states match
  }
}

class Expense {
  int id;
  String category;
  String amount;
  DateTime date;

  Expense({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      category: json['category'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }
}

class DateSelector extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final DateTime? initialDate;

  const DateSelector({Key? key, this.onDateSelected, this.initialDate})
      : super(key: key);

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          _selectedDate != null
              ? _selectedDate!.toString().split(' ')[0]
              : 'No date selected',
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: widget.initialDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              setState(() {
                _selectedDate = pickedDate;
              });
              if (widget.onDateSelected != null) {
                widget.onDateSelected!(pickedDate);
              }
            }
          },
          child: Text('Select Date'),
        ),
      ],
    );
  }
}
