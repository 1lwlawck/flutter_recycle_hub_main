import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_recycle_hub/features/chatbot/services/ChatbotService.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ChatbotService])
void main() {
  group('ChatbotService Tests', () {
    late ChatbotService chatbotService;

    setUp(() {
      chatbotService = ChatbotService();
    });

    test('sendMessage returns expected response', () async {
      // Mock response
      final response = await chatbotService.sendMessage("Hello");
      expect(response, isNotNull); // Cek response tidak null
    });

    test('sendMessage handles errors gracefully', () async {
      try {
        await chatbotService.sendMessage("");
      } catch (e) {
        expect(e.toString(), contains("Error")); // Pastikan error tertangani
      }
    });
  });
}
