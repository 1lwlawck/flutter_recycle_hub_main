import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_recycle_hub/features/chatbot/screens/ChatbotPage.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Chatbot Integration Test - Send and receive messages',
      (WidgetTester tester) async {
    // Muat halaman ChatbotPage
    await tester.pumpWidget(
      MaterialApp(
        home: Chatbotpage(),
      ),
    );

    // Verifikasi bahwa ChatbotPage muncul
    expect(find.byType(Chatbotpage), findsOneWidget);

    // Masukkan pesan pengguna ke TextField
    final inputField = find.byKey(const Key('chat_input_field'));
    final sendButton = find.byKey(const Key('send_button'));

    await tester.enterText(inputField, 'Apa itu daur ulang?');
    await tester.tap(sendButton);

    // Tunggu hingga UI diperbarui
    await tester.pumpAndSettle();

    // Verifikasi bahwa pesan pengguna ditampilkan
    expect(find.text('Apa itu daur ulang?'), findsOneWidget);

    // Verifikasi bahwa respons chatbot ditampilkan
    expect(find.byKey(const Key('chat_bubble_1')), findsOneWidget);
  });
}
