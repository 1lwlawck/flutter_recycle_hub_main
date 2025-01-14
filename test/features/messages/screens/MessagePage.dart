import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_recycle_hub/features/messages/screens/MessagePage.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  group('MessagePage Widget Tests', () {
    testWidgets('renders AppBar with title "Message"',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MessagePage()));
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text("Message"), findsOneWidget);
    });

    testWidgets('displays chat bubbles with messages',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MessagePage()));
      expect(find.byType(Container), findsWidgets);
      expect(find.textContaining("Hi, how are you?"), findsOneWidget);
    });

    testWidgets('sends a new message when send button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MessagePage()));
      await tester.enterText(find.byType(TextField), 'Hello!');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();
      expect(find.text('Hello!'), findsOneWidget);
    });
  });
}
