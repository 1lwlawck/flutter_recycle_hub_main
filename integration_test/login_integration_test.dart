import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_recycle_hub/features/auth/screens/LoginUserPage.dart';
import 'package:flutter_recycle_hub/splash/SecondSplash.dart';
import 'package:flutter_recycle_hub/core/routes/Routes.dart';
import 'package:flutter_recycle_hub/features/home/screens/Homepage.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SplashScreen2 transition to LoginScreen test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/', // Mulai langsung dari SplashScreen2
        routes: getAppRoutes(),
      ),
    );

    // Verifikasi bahwa SplashScreen2 muncul
    expect(find.byType(SplashScreen2), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);

    // Simulasikan klik tombol panah
    final arrowButton = find.byIcon(Icons.arrow_forward);
    expect(arrowButton, findsOneWidget);
    await tester.tap(arrowButton);
    await tester.pumpAndSettle();

    // Verifikasi bahwa navigasi ke LoginScreen berhasil
    expect(find.byType(SplashScreen2), findsNothing);
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('LoginScreen authentication and navigate to HomePage test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/login', // Mulai dari LoginScreen
        routes: getAppRoutes(),
      ),
    );

    // Verifikasi bahwa LoginScreen muncul
    expect(find.byType(LoginScreen), findsOneWidget);

    // Masukkan email dan password
    final emailField = find.byKey(const Key('email'));
    final passwordField = find.byKey(const Key('password'));
    final loginButton = find.text('Masuk');

    await tester.enterText(emailField, 'denyfaishalard@gmail.com');
    await tester.enterText(passwordField, '12345678');

    // Tap tombol login
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Verifikasi bahwa navigasi ke HomePage berhasil
    expect(find.byType(HomePage), findsOneWidget);
  });
}
