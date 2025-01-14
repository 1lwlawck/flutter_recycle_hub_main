import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_recycle_hub/core/models/Users.dart'; // Sesuaikan path ini

void main() {
  group('User Model Tests', () {
    // Data mock JSON untuk testing
    final mockJson = {
      'id': 1,
      'nama_user': 'John Doe',
      'is_verified': true,
      'jenis_kelamin': 'Laki-laki',
      'nomor_hp': '081234567890',
      'email': 'john.doe@example.com',
      'otp': '123456',
      'avatar': 'https://example.com/avatar.png',
      'points': 100,
      'role': 'admin',
      'tanggal_lahir': '1990-01-01',
    };

    // Data mock JSON dengan nilai null
    final mockJsonWithNull = {
      'id': 1,
      'nama_user': 'John Doe',
      'is_verified': true,
      'jenis_kelamin': null,
      'nomor_hp': null,
      'email': 'john.doe@example.com',
      'otp': null,
      'avatar': null,
      'points': 100,
      'role': 'admin',
      'tanggal_lahir': null,
    };

    test('fromJson should correctly parse JSON into User object', () {
      // Act
      final user = User.fromJson(mockJson);

      // Assert
      expect(user.id, 1);
      expect(user.namaUser, 'John Doe');
      expect(user.isVerified, true);
      expect(user.jenisKelamin, 'Laki-laki');
      expect(user.nomorHp, '081234567890');
      expect(user.email, 'john.doe@example.com');
      expect(user.otp, '123456');
      expect(user.avatar, 'https://example.com/avatar.png');
      expect(user.points, 100);
      expect(user.role, 'admin');
      expect(user.tanggalLahir, '1990-01-01');
    });

    test('fromJson should handle null values correctly', () {
      // Act
      final user = User.fromJson(mockJsonWithNull);

      // Assert
      expect(user.id, 1);
      expect(user.namaUser, 'John Doe');
      expect(user.isVerified, true);
      expect(user.jenisKelamin, null);
      expect(user.nomorHp, null);
      expect(user.email, 'john.doe@example.com');
      expect(user.otp, null);
      expect(user.avatar, null);
      expect(user.points, 100);
      expect(user.role, 'admin');
      expect(user.tanggalLahir, null);
    });
  });
}
