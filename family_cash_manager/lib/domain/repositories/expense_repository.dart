import 'package:family_cash_manager/domain/model/expense.dart';

abstract class ExpenseRepository {
  Future<void> save(Expense expense);
  Future<Expense?> findById(String id);
  Future<List<Expense>> findByUserId(String userId);
}
