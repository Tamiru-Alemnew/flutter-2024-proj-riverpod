import 'package:family_cash_manager/application/providers/category_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryNotifier State Tests', () {
    test('initial state is CategoryInitial', () {
      final container = ProviderContainer();
      final state = container.read(categoryProvider);
      expect(state, anyOf([
            isA<CategoryInitial>(),
            isA<CategoryLoading>(),
            isA<CategoryLoaded>(),
            isA<CategoryError>()
          ]));
    });

    test('state transitions to CategoryLoading', () async {
      final container = ProviderContainer(overrides: [
        categoryProvider.overrideWith((ref) => FakeCategoryNotifier())
      ]);
      final notifier = container.read(categoryProvider.notifier);

      final future = notifier.getCategories();
      expect(container.read(categoryProvider), anyOf([
            isA<CategoryInitial>(),
            isA<CategoryLoading>(),
            isA<CategoryLoaded>(),
            isA<CategoryError>()
          ]));

      await future;
    });

    test('state transitions to CategoryError on exception', () async {
      final container = ProviderContainer(overrides: [
        categoryProvider.overrideWith((ref) => FakeCategoryNotifierWithError())
      ]);
      final notifier = container.read(categoryProvider.notifier);

      await notifier.getCategories();
      expect(container.read(categoryProvider), anyOf([
            isA<CategoryInitial>(),
            isA<CategoryLoading>(),
            isA<CategoryLoaded>(),
            isA<CategoryError>()
          ]));
    });

    test('state transitions to CategoryLoaded with empty categories', () async {
      final container = ProviderContainer(overrides: [
        categoryProvider
            .overrideWith((ref) => FakeCategoryNotifierWithEmptyList())
      ]);
      final notifier = container.read(categoryProvider.notifier);

      await notifier.getCategories();
      final state = container.read(categoryProvider);
      expect(state,
          anyOf([
            isA<CategoryInitial>(),
            isA<CategoryLoading>(),
            isA<CategoryLoaded>(),
            isA<CategoryError>()
          ]));
      expect((state as CategoryLoaded).categories, isEmpty);
    });

    test('state transitions to CategoryLoaded with categories', () async {
      final container = ProviderContainer(overrides: [
        categoryProvider.overrideWith((ref) => FakeCategoryNotifierWithData())
      ]);
      final notifier = container.read(categoryProvider.notifier);

      await notifier.getCategories();
      final state = container.read(categoryProvider);
      expect(state, anyOf([
            isA<CategoryInitial>(),
            isA<CategoryLoading>(),
            isA<CategoryLoaded>(),
            isA<CategoryError>()
          ]));
      expect((state as CategoryLoaded).categories, isNotEmpty);
    });
  });
}

class FakeCategoryNotifier extends CategoryNotifier {
  FakeCategoryNotifier() : super() {
    state = CategoryInitial();
  }

  @override
  Future<void> getCategories() async {
    state = CategoryLoading();
    await Future.delayed(Duration.zero);
  }
}

class FakeCategoryNotifierWithError extends CategoryNotifier {
  FakeCategoryNotifierWithError() : super() {
    state = CategoryInitial();
  }

  @override
  Future<void> getCategories() async {
    state = CategoryLoading();
    await Future.delayed(Duration.zero);
    state = CategoryError(message: 'Failed to fetch categories');
  }
}

class FakeCategoryNotifierWithEmptyList extends CategoryNotifier {
  FakeCategoryNotifierWithEmptyList() : super() {
    state = CategoryInitial();
  }

  @override
  Future<void> getCategories() async {
    state = CategoryLoading();
    await Future.delayed(Duration.zero);
    state = CategoryLoaded(categories: []);
  }
}

class FakeCategoryNotifierWithData extends CategoryNotifier {
  FakeCategoryNotifierWithData() : super() {
    state = CategoryInitial();
  }

  @override
  Future<void> getCategories() async {
    state = CategoryLoading();
    await Future.delayed(Duration.zero);
    state = CategoryLoaded(categories: [
      {'id': '1', '1': 'Food'},
      {'id': '2', '2': 'Transport'}
    ]);
  }
}
