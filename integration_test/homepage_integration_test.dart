import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_recycle_hub/features/home/screens/Homepage.dart';
import 'package:flutter_recycle_hub/features/chatbot/screens/ChatbotPage.dart';
import 'package:flutter_recycle_hub/features/image-detection/screens/ImageDetection.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_recycle_hub/features/home/widgets/GrettingCard.dart';
import 'package:flutter_recycle_hub/core/routes/Routes.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('HomePage UI elements and navigation test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/home',
        routes: getAppRoutes(),
      ),
    );

    // Verifikasi bahwa HomePage muncul
    expect(find.byType(HomePage), findsOneWidget);

    // Verifikasi elemen Greeting Card
    expect(find.byType(UserGreeting), findsOneWidget);

    // Verifikasi Carousel
    expect(find.byType(CarouselSlider), findsOneWidget);

    // Verifikasi tombol Floating Camera
    final floatingCameraButton = find.byType(GestureDetector);
    expect(floatingCameraButton, findsWidgets);

    // Simulasikan klik tombol Floating Camera
    await tester.tap(floatingCameraButton.first);
    await tester.pumpAndSettle();

    // Verifikasi navigasi ke halaman ImageDetection
    expect(find.byType(ImageDetection), findsOneWidget);

    // Kembali ke HomePage
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    // Simulasikan klik tombol Chatbot
    final chatbotButton = find.text('Chatbot');
    expect(chatbotButton, findsOneWidget);

    await tester.tap(chatbotButton);
    await tester.pumpAndSettle();

    // Verifikasi navigasi ke ChatbotPage
    expect(find.byType(Chatbotpage), findsOneWidget);
  });
}
