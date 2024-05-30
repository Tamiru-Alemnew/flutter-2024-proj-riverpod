import 'package:family_cash_manager/domain/model/user.dart';

abstract class UserRepository {
  Future<User?> getUser(int userId);
  Future<void> saveUser(User user);
}
