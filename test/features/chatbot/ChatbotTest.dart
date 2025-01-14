import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_recycle_hub/features/chatbot/screens/Chatbotpage.dart';

void main() {
  group('ChatbotPage Widget Tests', () {
    testWidgets('renders AppBar with title "Chatbot"',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Chatbotpage()));

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Chatbot'), findsOneWidget);
    });

    testWidgets('renders input field and send button',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Chatbotpage()));

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.send), findsOneWidget);
    });

    testWidgets('sends a message and displays it in the chat',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Chatbotpage()));

      // Simulate entering text and sending message
      await tester.enterText(find.byType(TextField), 'Halo');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      // Verify the user message is displayed
      expect(find.text('Halo'), findsOneWidget);
    });
  });
}
