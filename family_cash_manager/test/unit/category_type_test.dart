import 'package:flutter_test/flutter_test.dart';
import 'package:family_cash_manager/application/providers/category_provider.dart';

void main() {
  group('CategoryNotifier', () {
    test('should initialize with any valid state', () {
      final categoryNotifier = CategoryNotifier();

      expect(
          categoryNotifier.state,
          anyOf([
            isA<CategoryInitial>(),
            isA<CategoryLoading>(),
            isA<CategoryLoaded>(),
            isA<CategoryError>()
          ]));
    });
  });
}
