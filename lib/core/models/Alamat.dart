class Alamat {
  final int id;
  final int userId;
  final String? provinsi;
  final String? kabupatenKota;
  final String? kecamatan;
  final String? desa;
  final String? kodePos;
  final String? alamatLengkap;
  final String? nomorHp;

  Alamat({
    required this.id,
    required this.userId,
    this.provinsi,
    this.kabupatenKota,
    this.kecamatan,
    this.desa,
    this.kodePos,
    this.alamatLengkap,
    this.nomorHp,
  });

  // Factory untuk konversi dari JSON ke objek Alamat
  factory Alamat.fromJson(Map<String, dynamic> json) {
    return Alamat(
      id: json['id'],
      userId: json['user_id'],
      provinsi: json['provinsi'],
      kabupatenKota: json['kabupaten_kota'],
      kecamatan: json['kecamatan'],
      desa: json['desa'],
      kodePos: json['kode_pos'],
      alamatLengkap: json['alamat_lengkap'],
      nomorHp: json['nomor_hp'],
    );
  }

  // Fungsi untuk konversi dari objek Alamat ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'provinsi': provinsi,
      'kabupaten_kota': kabupatenKota,
      'kecamatan': kecamatan,
      'desa': desa,
      'kode_pos': kodePos,
      'alamat_lengkap': alamatLengkap,
      'nomor_hp': nomorHp,
    };
  }
}
