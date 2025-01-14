import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_recycle_hub/features/orders/screens/OrderFillPage.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null; // Menonaktifkan override HTTP untuk pengujian
  });

  group('OrderPage and RincianOrderPage Widget Tests', () {
    group('OrderPage Widget Tests', () {
      testWidgets('renders AppBar with title "Order Saya"',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: OrderPage()));
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text("Order Saya"), findsOneWidget);
      });

      testWidgets('displays list of orders', (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: OrderPage()));
        expect(find.byType(Container), findsWidgets); // Memeriksa daftar order
      });
    });
  });
}
