import 'package:family_cash_manager/presentation/screens/children.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ManageChildren widget - Renders some widgets',
      (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
     ProviderScope(child:  MaterialApp(
        home: ManageChildren(),
      ),
    )
    );

    // Verify that some widgets are rendered
    expect(find.byType(ManageChildren), findsOneWidget);
  });

  testWidgets('ChildrenPage widget - Renders some widgets',
      (WidgetTester tester) async {
    
    await tester.pumpWidget(
      ProviderScope(child: MaterialApp(
        home: ChildrenPage(),
      ),
    )
    );
    expect(find.byType(ChildrenPage), findsOneWidget);
  });
}
