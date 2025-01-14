import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_recycle_hub/core/models/Alamat.dart'; // Sesuaikan path ini

void main() {
  group('Alamat Model Tests', () {
    // Contoh JSON data
    final Map<String, dynamic> mockJson = {
      'id': 1,
      'user_id': 123,
      'provinsi': 'Jawa Barat',
      'kabupaten_kota': 'Bandung',
      'kecamatan': 'Coblong',
      'desa': 'Dago',
      'kode_pos': '40135',
      'alamat_lengkap': 'Jl. Ir. H. Juanda No.10',
      'nomor_hp': '081234567890',
    };

    test('fromJson should correctly parse JSON into Alamat object', () {
      // Act
      final alamat = Alamat.fromJson(mockJson);

      // Assert
      expect(alamat.id, 1);
      expect(alamat.userId, 123);
      expect(alamat.provinsi, 'Jawa Barat');
      expect(alamat.kabupatenKota, 'Bandung');
      expect(alamat.kecamatan, 'Coblong');
      expect(alamat.desa, 'Dago');
      expect(alamat.kodePos, '40135');
      expect(alamat.alamatLengkap, 'Jl. Ir. H. Juanda No.10');
      expect(alamat.nomorHp, '081234567890');
    });

    test('toJson should correctly convert Alamat object into JSON', () {
      // Arrange
      final alamat = Alamat(
        id: 1,
        userId: 123,
        provinsi: 'Jawa Barat',
        kabupatenKota: 'Bandung',
        kecamatan: 'Coblong',
        desa: 'Dago',
        kodePos: '40135',
        alamatLengkap: 'Jl. Ir. H. Juanda No.10',
        nomorHp: '081234567890',
      );

      // Act
      final json = alamat.toJson();

      // Assert
      expect(json, mockJson);
    });

    test('fromJson should handle null values correctly', () {
      // Arrange
      final Map<String, dynamic> mockJsonWithNulls = {
        'id': 1,
        'user_id': 123,
        'provinsi': null,
        'kabupaten_kota': null,
        'kecamatan': null,
        'desa': null,
        'kode_pos': null,
        'alamat_lengkap': null,
        'nomor_hp': null,
      };

      // Act
      final alamat = Alamat.fromJson(mockJsonWithNulls);

      // Assert
      expect(alamat.id, 1);
      expect(alamat.userId, 123);
      expect(alamat.provinsi, null);
      expect(alamat.kabupatenKota, null);
      expect(alamat.kecamatan, null);
      expect(alamat.desa, null);
      expect(alamat.kodePos, null);
      expect(alamat.alamatLengkap, null);
      expect(alamat.nomorHp, null);
    });
  });
}
