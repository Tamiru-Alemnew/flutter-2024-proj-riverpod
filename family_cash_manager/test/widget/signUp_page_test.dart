import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:family_cash_manager/presentation/screens/signup.dart'; 

void main() {
  testWidgets('SignUp Widget Test', (WidgetTester tester) async {
    
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: SignUp(),
        ),
      ),
    );

    expect(find.text('Signup'), findsOneWidget); // Ensure AppBar title

    // Example of testing the leading IconButton in AppBar
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // testing a specific text widget
    expect(find.text('SignUp with Email'), findsOneWidget);

  });
}
