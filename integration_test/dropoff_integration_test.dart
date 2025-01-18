import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_recycle_hub/features/dropoff/screens/main/DropOffPage.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Drop Off Page Integration Test', () {
    testWidgets('Drop Off Page Flow', (WidgetTester tester) async {
      // Jalankan aplikasi dan mulai dari halaman Drop Off
      await tester.pumpWidget(const MaterialApp(
        home: DropOffPage(), // Ganti dengan widget DropOffPage
      ));
      await tester.pumpAndSettle();

      // Verifikasi bahwa halaman Drop Off tampil
      expect(find.text('Drop Off'), findsOneWidget);

      // Increment weight
      final incrementButton = find.byIcon(Icons.add_circle_outline);
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();

      // Verifikasi berat bertambah
      expect(find.text('2 Kg'), findsOneWidget);

      // Pilih jenis plastik
      final plasticCheckbox = find.text('Botol Plastik');
      await tester.tap(plasticCheckbox);
      await tester.pumpAndSettle();

      // Verifikasi checkbox terpilih
      final checkbox = find.byType(Checkbox).first;
      expect((tester.widget(checkbox) as Checkbox).value, isTrue);

      // Klik tombol tambah gambar
      final addImageButton = find.text('Tambahkan Gambar');
      await tester.tap(addImageButton);
      await tester.pumpAndSettle();

      // Simulasi navigasi ke halaman informasi Drop Off
      final nextButton = find.text('Selanjutnya');
      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      // Verifikasi bahwa halaman Informasi Drop Off tampil
      expect(find.text('Informasi Drop Off'), findsOneWidget);

      // Pilih tanggal
      await tester.tap(find.text('Tanggal Pengantaran'));
      await tester.pumpAndSettle();

      final dateOkButton = find.text('OK');
      await tester.tap(dateOkButton);
      await tester.pumpAndSettle();

      // Pilih waktu
      final timeDropdown = find.text('Waktu Pengiriman');
      await tester.tap(timeDropdown);
      await tester.pumpAndSettle();

      final timeOption = find.text('08:00-11:00').last;
      await tester.tap(timeOption);
      await tester.pumpAndSettle();

      // Simulasi navigasi ke halaman Nearby Waste Bank
      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      // Verifikasi bahwa halaman Nearby Waste Bank tampil
      expect(find.text('Bank Sampah Terdekat'), findsOneWidget);

      // Pilih bank sampah
      final wasteBankCard = find.text('Bank Sampah Dewi Sinta');
      await tester.tap(wasteBankCard);
      await tester.pumpAndSettle();

      // Verifikasi bahwa bank sampah terpilih
      expect(find.text('Bank Sampah Dewi Sinta'), findsOneWidget);

      // Klik tombol selanjutnya
      final finalNextButton = find.text('Selanjutnya');
      await tester.tap(finalNextButton);
      await tester.pumpAndSettle();

      // Verifikasi proses selesai atau pindah halaman
    });
  });
}
