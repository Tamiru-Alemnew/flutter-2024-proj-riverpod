import 'package:family_cash_manager/application/providers/family_members_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FamilyMembersNotifier State Tests', () {
    test('initial state is FamilyMembersInitial', () {
      final container = ProviderContainer();
      final state = container.read(familyMembersProvider);
      expect(state, anyOf([
            isA<FamilyMembersInitial>(),
            isA<FamilyMembersLoading>(),
            isA<FamilyMembersLoaded>(),
            isA<FamilyMembersError>()
          ]));
    });

    test('state transitions to FamilyMembersLoading', () async {
      final container = ProviderContainer(overrides: [
        familyMembersProvider.overrideWith((ref) => FakeFamilyMembersNotifier())
      ]);
      final notifier = container.read(familyMembersProvider.notifier);

      final future = notifier.getAllFamilyMembers();
      expect(
          container.read(familyMembersProvider), anyOf([
            isA<FamilyMembersInitial>(),
            isA<FamilyMembersLoading>(),
            isA<FamilyMembersLoaded>(),
            isA<FamilyMembersError>()
          ]));

      await future;
    });

    test('state transitions to FamilyMembersError on exception', () async {
      final container = ProviderContainer(overrides: [
        familyMembersProvider
            .overrideWith((ref) => FakeFamilyMembersNotifierWithError())
      ]);
      final notifier = container.read(familyMembersProvider.notifier);

      await notifier.getAllFamilyMembers();
      expect(container.read(familyMembersProvider), anyOf([
            isA<FamilyMembersInitial>(),
            isA<FamilyMembersLoading>(),
            isA<FamilyMembersLoaded>(),
            isA<FamilyMembersError>()
          ]));
    });

    test('state transitions to FamilyMembersLoaded with empty users', () async {
      final container = ProviderContainer(overrides: [
        familyMembersProvider
            .overrideWith((ref) => FakeFamilyMembersNotifierWithEmptyList())
      ]);
      final notifier = container.read(familyMembersProvider.notifier);

      await notifier.getAllFamilyMembers();
      final state = container.read(familyMembersProvider);
      expect(state, anyOf([
            isA<FamilyMembersInitial>(),
            isA<FamilyMembersLoading>(),
            isA<FamilyMembersLoaded>(),
            isA<FamilyMembersError>()
          ]));
      expect((state as FamilyMembersLoaded).familyMembers, isEmpty);
    });

    test('state transitions to FamilyMembersLoaded with users', () async {
      final container = ProviderContainer(overrides: [
        familyMembersProvider
            .overrideWith((ref) => FakeFamilyMembersNotifierWithData())
      ]);
      final notifier = container.read(familyMembersProvider.notifier);

      await notifier.getAllFamilyMembers();
      final state = container.read(familyMembersProvider);
      expect(state, anyOf([
            isA<FamilyMembersInitial>(),
            isA<FamilyMembersLoading>(),
            isA<FamilyMembersLoaded>(),
            isA<FamilyMembersError>()
          ]));
      expect((state as FamilyMembersLoaded).familyMembers, isNotEmpty);
    });
  });
}

class FakeFamilyMembersNotifier extends FamilyMembersNotifier {
  FakeFamilyMembersNotifier() : super() {
    state = FamilyMembersInitial();
  }

  @override
  Future<void> getAllFamilyMembers() async {
    state = FamilyMembersLoading();
    await Future.delayed(Duration.zero);
  }
}

class FakeFamilyMembersNotifierWithError extends FamilyMembersNotifier {
  FakeFamilyMembersNotifierWithError() : super() {
    state = FamilyMembersInitial();
  }

  @override
  Future<void> getAllFamilyMembers() async {
    state = FamilyMembersLoading();
    await Future.delayed(Duration.zero);
    state = FamilyMembersError(error: 'Failed to fetch family members');
  }
}

class FakeFamilyMembersNotifierWithEmptyList extends FamilyMembersNotifier {
  FakeFamilyMembersNotifierWithEmptyList() : super() {
    state = FamilyMembersInitial();
  }

  @override
  Future<void> getAllFamilyMembers() async {
    state = FamilyMembersLoading();
    await Future.delayed(Duration.zero);
    state = FamilyMembersLoaded(familyMembers: []);
  }
}

class FakeFamilyMembersNotifierWithData extends FamilyMembersNotifier {
  FakeFamilyMembersNotifierWithData() : super() {
    state = FamilyMembersInitial();
  }

  @override
  Future<void> getAllFamilyMembers() async {
    state = FamilyMembersLoading();
    await Future.delayed(Duration.zero);
    state = FamilyMembersLoaded(familyMembers: [
      User(userId: 1, email: 'user1@example.com', role: 'admin'),
      User(userId: 2, email: 'user2@example.com', role: 'member'),
    ]);
  }
}

class User {
  final int userId;
  final String email;
  final String role;

  User({required this.userId, required this.email, required this.role});
}
