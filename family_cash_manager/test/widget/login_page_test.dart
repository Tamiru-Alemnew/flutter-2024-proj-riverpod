import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:family_cash_manager/presentation/screens/login_page.dart';

void main() {
  testWidgets('LoginPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: LoginPage(),
        ),
      ),
    );

    expect(find.text('Log in to FamilyCash Manager'), findsOneWidget);
    expect(find.text('Your email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);


  });
}
