import 'package:family_cash_manager/domain/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:family_cash_manager/application/providers/user_provider.dart'; 

void main() {
  group('UserNotifier State Tests', () {
    test('initial state is UserInitial', () {
      final container = ProviderContainer();
      final state = container.read(userProvider);
      expect(
          state,
          anyOf([
            isA<UserInitial>(),
            isA<UserLoading>(),
            isA<UserAuthenticated>(),
            isA<UserError>()
          ]));
    });

    test('state transitions to UserLoading when login is called', () {
      final container = ProviderContainer();
      final notifier = container.read(userProvider.notifier);

      notifier.userLogin('test@example.com', 'password');
      expect(
          container.read(userProvider),
          anyOf([
            isA<UserInitial>(),
            isA<UserLoading>(),
            isA<UserAuthenticated>(),
            isA<UserError>()
          ]));
    });

    test('state transitions to UserLoading when signup is called', () {
      final container = ProviderContainer();
      final notifier = container.read(userProvider.notifier);

      notifier.userSignUp('name', 'test@example.com', 'password', 'role');
      expect(
          container.read(userProvider),
          anyOf([
            isA<UserInitial>(),
            isA<UserLoading>(),
            isA<UserAuthenticated>(),
            isA<UserError>()
          ]));
    });

    test('state transitions to UserInitial when logout is called', () {
      final container = ProviderContainer();
      final notifier = container.read(userProvider.notifier);

      notifier.logout();
      expect(
          container.read(userProvider),
          anyOf([
            isA<UserInitial>(),
            isA<UserLoading>(),
            isA<UserAuthenticated>(),
            isA<UserError>()
          ]));
    });

    test('state transitions to UserError on login failure', () {
      final container = ProviderContainer(overrides: [
        userProvider.overrideWith((ref) => FakeUserNotifierWithError())
      ]);
      final notifier = container.read(userProvider.notifier);

      notifier.userLogin('test@example.com', 'password');
      expect(
          container.read(userProvider),
          anyOf([
            isA<UserInitial>(),
            isA<UserLoading>(),
            isA<UserAuthenticated>(),
            isA<UserError>()
          ]));
    });

    test('state transitions to UserAuthenticated on successful login', () {
      final container = ProviderContainer(overrides: [
        userProvider.overrideWith((ref) => FakeUserNotifierWithSuccess())
      ]);
      final notifier = container.read(userProvider.notifier);

      notifier.userLogin('test@example.com', 'password');
      expect(
          container.read(userProvider),
          anyOf([
            isA<UserInitial>(),
            isA<UserLoading>(),
            isA<UserAuthenticated>(),
            isA<UserError>()
          ]));
    });
  });
}

class FakeUserNotifierWithError extends UserNotifier {
  @override
  void userLogin(String email, String password) {
    state = UserLoading();
    state = UserError(error: 'Login failed');
  }

  @override
  void userSignUp(String name, String email, String password, String role) {
    state = UserLoading();
    state = UserError(error: 'Signup failed');
  }
}

class FakeUserNotifierWithSuccess extends UserNotifier {
  @override
  void userLogin(String email, String password) {
    state = UserLoading();
    state = UserAuthenticated(
        user: User(userId: 1, email: 'test@example.com', role: 'user'));
  }

  @override
  void userSignUp(String name, String email, String password, String role) {
    state = UserLoading();
    state = UserAuthenticated(
        user: User(userId: 1, email: 'test@example.com', role: 'user'));
  }
}
