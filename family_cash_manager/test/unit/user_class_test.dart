import 'package:family_cash_manager/domain/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    test('should create User object with correct properties', () {
      final user = User(userId: 1, email: 'test@example.com', role: 'admin');

      expect(user.userId, 1);
      expect(user.email, 'test@example.com');
      expect(user.role, 'admin');
    });
  });
}
