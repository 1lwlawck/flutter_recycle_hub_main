import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_recycle_hub/features/account/screens/KebijakanPrivasiPage.dart';
import 'package:flutter_recycle_hub/features/account/screens/PanduanPenggunaPage.dart';
import 'package:flutter_recycle_hub/features/account/screens/SyaratKetentuanPage.dart';
import 'package:flutter_recycle_hub/features/account/screens/UlasanMasukanPage.dart';

void main() {
  setUpAll(() {
    // Pastikan pengaturan HTTP tidak dicegah selama pengujian
    HttpOverrides.global = null;
  });

  group('KebijakanPrivasiPage Widget Tests', () {
    testWidgets('renders AppBar with title "Kebijakan Privasi"',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: KebijakanPrivasiPage()));
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text("Kebijakan Privasi"), findsOneWidget);
    });

    testWidgets('navigates back when arrow back is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Navigator(
            onGenerateRoute: (_) => MaterialPageRoute(
              builder: (_) => const KebijakanPrivasiPage(),
            ),
          ),
        ),
      );
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byType(KebijakanPrivasiPage), findsNothing);
    });

    testWidgets('renders title "Kebijakan Privasi RecycleHub" and content',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: KebijakanPrivasiPage()));
      expect(find.text("Kebijakan Privasi RecycleHub"), findsOneWidget);
      expect(find.text("Mulai dari Oktober 2024"), findsOneWidget);
      expect(find.textContaining("Pengenalan"), findsOneWidget);
      expect(
          find.textContaining("Informasi yang Kami Kumpulkan"), findsOneWidget);
      expect(find.textContaining("Keamanan Data"), findsOneWidget);
    });
  });

  group('PanduanPage Widget Tests', () {
    testWidgets('renders AppBar with title "Panduan Pengguna"',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PanduanPage()));
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text("Panduan Pengguna"), findsOneWidget);
    });

    testWidgets('renders expansion tiles with correct titles',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PanduanPage()));
      expect(find.text("Registrasi"), findsOneWidget);
      expect(find.text("Drop Off Sampah"), findsOneWidget);
      expect(find.text("Jenis dan Harga Sampah"), findsOneWidget);
      expect(find.text("Menjadi Mitra"), findsOneWidget);
    });

    testWidgets('expands and shows content when ExpansionTile is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PanduanPage()));
      final registrasiTile = find.text("Registrasi");
      expect(find.text("Panduan Registrasi"), findsNothing);
      await tester.tap(registrasiTile);
      await tester.pumpAndSettle();
      expect(find.text("Panduan Registrasi"), findsOneWidget);
      expect(find.textContaining("Lorem ipsum"), findsWidgets);
    });

    testWidgets('renders back button and navigates back when tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Navigator(
          onGenerateRoute: (_) =>
              MaterialPageRoute(builder: (_) => const PanduanPage()),
        ),
      ));
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byType(PanduanPage), findsNothing);
    });
  });

  group('SyaratKetentuanPage Widget Tests', () {
    testWidgets('renders AppBar with title "Syarat & Ketentuan"',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SyaratKetentuanPage()));
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text("Syarat & Ketentuan"), findsOneWidget);
    });

    testWidgets('renders the main title "Syarat dan Ketentuan"',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SyaratKetentuanPage()));
      expect(find.text("Syarat dan Ketentuan"), findsOneWidget);
    });

    testWidgets('renders content text properly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SyaratKetentuanPage()));
      expect(find.textContaining("Penerimaan Syarat dan Ketentuan"),
          findsOneWidget);
      expect(find.textContaining("Penggunaan Aplikasi"), findsOneWidget);
      expect(find.textContaining("Akun Pengguna"), findsOneWidget);
      expect(find.textContaining("Kebijakan Privasi"), findsOneWidget);
    });

    testWidgets('renders back button and navigates back when tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Navigator(
          onGenerateRoute: (_) =>
              MaterialPageRoute(builder: (_) => const SyaratKetentuanPage()),
        ),
      ));
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byType(SyaratKetentuanPage), findsNothing);
    });
  });

  group('UlasanMasukanPage Widget Tests with Real API', () {
    testWidgets('renders TextField and Button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: UlasanMasukanPage()));
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Kirim'), findsOneWidget);
    });
  });
}
