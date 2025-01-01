// lib/core/models/User.dart

class User {
  final int id;
  final String namaUser;
  final bool isVerified;
  final String? jenisKelamin;
  final String? nomorHp;
  final String email;
  final String? otp;
  final int points;
  final String role;
  final String? tanggalLahir;

  User({
    required this.id,
    required this.namaUser,
    required this.isVerified,
    this.jenisKelamin,
    this.nomorHp,
    required this.email,
    this.otp,
    required this.points,
    required this.role,
    this.tanggalLahir,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      namaUser: json['nama_user'] as String,
      isVerified: json['is_verified'] as bool,
      jenisKelamin: json['jenis_kelamin'] as String?,
      nomorHp: json['nomor_hp'] as String?,
      email: json['email'] as String,
      otp: json['otp'] as String?,
      points: json['points'] as int,
      role: json['role'] as String,
      tanggalLahir: json['tanggal_lahir'] as String?,
    );
  }
}
