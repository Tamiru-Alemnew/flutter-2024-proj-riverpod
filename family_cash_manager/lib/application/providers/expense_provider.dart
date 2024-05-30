import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final expenseProvider = StateNotifierProvider<ExpenseNotifier, ExpenseState>(
    (ref) => ExpenseNotifier());

class ExpenseNotifier extends StateNotifier<ExpenseState> {
  final String baseUrl = 'http://localhost:3000/expense';

  ExpenseNotifier() : super(ExpenseInitial()) {
    getExpenses();
  }

  Future<void> getExpenses() async {
    state = ExpenseLoading();
    try {
      final response = await http.get(Uri.parse(baseUrl));
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        state = ExpenseLoaded(expenses: data);
      } else {
        state = ExpenseError(error: 'Failed to fetch expenses');
      }
    } catch (e) {
      state = ExpenseError(error: 'Failed to fetch expenses');
    }
  }

  Future<void> addExpense(
      int userId, String category, String amount, String date) async {
    state = ExpenseLoading();
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: {
          'userId': userId.toString(),
          'category': category,
          'amount': amount,
          'date': date,
        },
      );
      getExpenses();
    } catch (e) {
      state = ExpenseError(error: 'Failed to add expenses');
    }
  }

  Future<void> deleteExpense(int id) async {
    state = ExpenseLoading();
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      getExpenses();
    } catch (e) {
      state = ExpenseError(error: 'Failed to delete expense');
    }
  }

  Future<void> updateExpense(
      int id, int userId, String category, String amount, String date) async {
    state = ExpenseLoading();
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        body: {
          'userId': userId.toString(),
          'category': category,
          'amount': amount,
          'date': date,
        },
      );
      getExpenses();
    } catch (e) {
      state = ExpenseError(error: 'Failed to update expense');
    }
  }
}

abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List expenses;
  ExpenseLoaded({required this.expenses});
}

class ExpenseError extends ExpenseState {
  final String error;
  ExpenseError({required this.error});
}
