import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:family_cash_manager/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Test', () {
    testWidgets('Login and navigate through the app',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Wait to observe the login screen
      await tester.pump(const Duration(seconds: 2));

      // Verify we are on the login screen
      expect(find.text('Log in to FamilyCash Manager'), findsOneWidget);
      expect(find.byType(TextField),
          findsNWidgets(2)); // email and password fields

      // Enter email and password
      final emailField = find.byKey(Key('emailField'));
      final passwordField = find.byKey(Key('passwordField'));
      final loginButton = find.byKey(Key('loginButton'));

      await tester.ensureVisible(emailField);
      await tester.enterText(emailField, 'tamiru@gmail.com');
      await tester.pump(const Duration(seconds: 1)); // Wait to observe

      await tester.ensureVisible(passwordField);
      await tester.enterText(passwordField, 'Aguero@1');
      await tester.pump(const Duration(seconds: 1)); // Wait to observe

      await tester.ensureVisible(loginButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Wait to observe the home screen
      await tester.pump(const Duration(seconds: 2));

      // Verify we are on the home screen
      expect(find.text('Family Cash Manager'), findsOneWidget);

      // Open the sidebar
      final navigationMenuButton = find.byTooltip('Open navigation menu');
      await tester.ensureVisible(navigationMenuButton);
      await tester.tap(navigationMenuButton);
      await tester.pumpAndSettle();

      // Wait to observe the sidebar
      await tester.pump(const Duration(seconds: 2));

      // Navigate to Edit Categories screen
      final editCategoriesOption = find.text('Edit Categories');
      await tester.ensureVisible(editCategoriesOption);
      await tester.tap(editCategoriesOption);
      await tester.pumpAndSettle();

      // Wait to observe the Edit Categories screen
      await tester.pump(const Duration(seconds: 2));

      // Verify back button
      await tester.tap(navigationMenuButton);
      await tester.pumpAndSettle();
      expect(find.text('Family Cash Manager'), findsOneWidget);

      // Wait to observe the home screen again
      await tester.pump(const Duration(seconds: 2));

      // Verify we are on the Manage Children screen
      expect(find.text('Manage Children'), findsOneWidget);

      // Logout
      await tester.ensureVisible(navigationMenuButton);
      await tester.tap(navigationMenuButton);
      await tester.pumpAndSettle();

      // Wait to observe the sidebar again
      await tester.pump(const Duration(seconds: 2));

      final logoutOption = find.text('Logout');
      await tester.ensureVisible(logoutOption);
      await tester.tap(logoutOption);
      await tester.pumpAndSettle();

      // Wait to observe the logout process
      await tester.pump(const Duration(seconds: 2));

      // Verify we are back on the login screen
      expect(find.text('Log in to FamilyCash Manager'), findsOneWidget);

      // Final wait to observe the login screen
      await tester.pump(const Duration(seconds: 2));
    });
  });
}

// Command to run the test
// flutter drive --driver=integration_test/integration_test_driver.dart --target=integration_test/login_test.dart
