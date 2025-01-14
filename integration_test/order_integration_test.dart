import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_recycle_hub/features/orders/screens/OrderFillPage.dart';
import 'package:flutter_recycle_hub/features/orders/screens/OrderRincianPage.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('OrderPage and RincianOrderPage Integration Test',
      (WidgetTester tester) async {
    // Muat halaman OrderPage
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/orders',
        routes: {
          '/orders': (context) => const OrderPage(),
          '/rincian-order': (context) => const RincianOrderPage(),
        },
      ),
    );

    // Verifikasi OrderPage muncul
    expect(find.byType(OrderPage), findsOneWidget);

    // Verifikasi elemen OrderPage
    expect(find.text('Order Saya'), findsOneWidget);
    expect(find.text('Drop Off'), findsWidgets); // Ada dua card "Drop Off"
    expect(find.byIcon(Icons.local_shipping), findsWidgets); // Ikon Shipping
    expect(find.text('Menunggu Konfirmasi'), findsWidgets);

    // Ketuk salah satu card order
    final orderCard = find.text('Drop Off').first;
    await tester.tap(orderCard);
    await tester.pumpAndSettle();

    // Verifikasi navigasi ke RincianOrderPage
    expect(find.byType(RincianOrderPage), findsOneWidget);

    // Verifikasi elemen RincianOrderPage
    expect(find.text('Rincian Order'), findsOneWidget);
    expect(find.text('Alamat Bank Sampah'), findsOneWidget);
    expect(find.text('Polyethylene Terephthalate (PET)'), findsOneWidget);
    expect(find.text('Masih diproses'), findsOneWidget);

    // Ketuk tombol "Butuh Bantuan ?"
    final bantuanButton = find.text('Butuh Bantuan ?');
    await tester.tap(bantuanButton);
    await tester.pumpAndSettle();

    // Simulasikan aksi setelah mengetuk tombol "Butuh Bantuan ?"
    // (Tambahkan logika jika ada navigasi lebih lanjut atau dialog terbuka)
  });
}
