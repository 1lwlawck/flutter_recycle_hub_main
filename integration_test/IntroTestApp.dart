import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_recycle_hub/features/auth/screens/LoginUserPage.dart';
import 'package:flutter_recycle_hub/splash/FirstSplash.dart';
import 'package:flutter_recycle_hub/splash/SecondSplash.dart';
import 'package:flutter_recycle_hub/core/routes/Routes.dart';
import 'package:flutter_recycle_hub/features/home/screens/Homepage.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SplashScreen1 transition to SplashScreen2 test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/',
        routes: getAppRoutes(),
      ),
    );

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(SplashScreen2), findsNothing);

    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();

    expect(find.byType(SplashScreen), findsNothing);
    expect(find.byType(SplashScreen2), findsOneWidget);
  });

  testWidgets('SplashScreen2 transition to LoginScreen test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/splash2',
        routes: getAppRoutes(),
      ),
    );

    expect(find.byType(SplashScreen2), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);

    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();

    expect(find.byType(SplashScreen2), findsNothing);
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('LoginScreen authentication test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/login',
        routes: getAppRoutes(),
      ),
    );

    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.enterText(
        find.byType(TextField).at(0), 'denyfaishalard@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), '123456789');

    final loginButton = find.text('Masuk');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });
}
