import 'package:family_cash_manager/domain/model/category.dart';

abstract class CategoryRepository {
  Future<void> save(Category category);
  Future<Category?> findById(String id);
  Future<List<Category>> findAll();
}
