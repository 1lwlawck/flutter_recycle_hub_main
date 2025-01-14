import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_recycle_hub/features/messages/screens/MessageFillPage.dart';
import 'package:flutter_recycle_hub/features/messages/screens/MessagePage.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  group('FillMessagePage Widget Tests', () {
    testWidgets('renders AppBar with title "Message"',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: FillMessagePage()));
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text("Message"), findsOneWidget);
    });

    testWidgets('displays list of messages', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: FillMessagePage()));
      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('navigates to MessagePage when a message item is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const FillMessagePage(),
      ));
      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();
      expect(find.byType(MessagePage), findsOneWidget);
    });
  });
}
