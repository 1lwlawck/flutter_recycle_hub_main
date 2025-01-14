import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_recycle_hub/features/account/services/UlasanService.dart';

void main() {
  group('UlasanService Tests with Real API', () {
    const String _ = 'https://recyclehub.cretv.xyz/api/sentiment/analyze';

    test('returns success response from real API', () async {
      // Panggil API asli
      final response =
          await UlasanService.postUlasan('Test ulasan menggunakan API asli');

      // Verifikasi respons sukses
      expect(response["success"], true);
      expect(response["data"]["sentiment"], isNotNull);
    });

    test('handles error response from real API', () async {
      // Simulasi data kosong yang kemungkinan menyebabkan error
      final response = await UlasanService.postUlasan('');

      // Verifikasi bahwa respons adalah error
      expect(response["success"], false);
      expect(response["error"], isNotNull);
    });
  });
}
