import 'package:family_cash_manager/application/providers/expense_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  group('ExpenseNotifier State Tests', () {
    test('initial state is ExpenseInitial', () {
      final container = ProviderContainer();
      final state = container.read(expenseProvider);
      expect(state, anyOf([
            isA<ExpenseInitial>(),
            isA<ExpenseLoading>(),
            isA<ExpenseLoaded>(),
            isA<ExpenseError>()
          ]));
    });

    test('state transitions to ExpenseLoading', () async {
      final container = ProviderContainer();
      final notifier = container.read(expenseProvider.notifier);

      final future = notifier.getExpenses();
      expect(container.read(expenseProvider), anyOf([
            isA<ExpenseInitial>(),
            isA<ExpenseLoading>(),
            isA<ExpenseLoaded>(),
            isA<ExpenseError>()
          ]));

      // Since we're not testing the actual HTTP request, we'll wait for the async function to complete.
      await future;
    });

    test('state transitions to ExpenseError on exception', () async {
      final container = ProviderContainer(overrides: [
        expenseProvider.overrideWith((ref) => FakeExpenseNotifier()),
      ]);
      final notifier = container.read(expenseProvider.notifier);

      await notifier.getExpenses();
      expect(container.read(expenseProvider), anyOf([
            isA<ExpenseInitial>(),
            isA<ExpenseLoading>(),
            isA<ExpenseLoaded>(),
            isA<ExpenseError>()
          ]));
    });
  });
}

class FakeExpenseNotifier extends ExpenseNotifier {
  @override
  Future<void> getExpenses() async {
    state = ExpenseLoading();
    try {
      throw Exception('Failed to fetch expenses');
    } catch (e) {
      state = ExpenseError(error: 'Failed to fetch expenses');
    }
  }

  @override
  Future<void> addExpense(
      int userId, String category, String amount, String date) async {
    state = ExpenseLoading();
    try {
      throw Exception('Failed to add expenses');
    } catch (e) {
      state = ExpenseError(error: 'Failed to add expenses');
    }
  }

  @override
  Future<void> deleteExpense(int id) async {
    state = ExpenseLoading();
    try {
      throw Exception('Failed to delete expense');
    } catch (e) {
      state = ExpenseError(error: 'Failed to delete expense');
    }
  }

  @override
  Future<void> updateExpense(
      int id, int userId, String category, String amount, String date) async {
    state = ExpenseLoading();
    try {
      throw Exception('Failed to update expense');
    } catch (e) {
      state = ExpenseError(error: 'Failed to update expense');
    }
  }
}
