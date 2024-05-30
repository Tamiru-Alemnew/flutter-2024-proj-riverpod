import 'package:family_cash_manager/domain/model/budget.dart';

abstract class BudgetRepository {
  Future<void> save(Budget budget);
  Future<Budget?> findById(String id);
  Future<List<Budget>> findAll();
  Future<void> delete(String id);
}
