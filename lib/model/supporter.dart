class Supporter {
  dynamic id;
  String nama;
  String alamat;
  String tglDaftar;
  String noTelpon;
  String foto;

  Supporter({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.tglDaftar,
    required this.noTelpon,
    required this.foto,
  });

  // Method untuk membuat objek Supporter dari JSON
  factory Supporter.fromJson(Map<String, dynamic> json) {
    return Supporter(
      id: json['id'],
      nama: json['nama'] as String,
      alamat: json['alamat'] as String,
      tglDaftar: json['tgl_daftar'] as String,
      noTelpon: json['no_telpon'] as String,
      foto: json['foto'] as String,
    );
  }

  // Method untuk mengkonversi objek Supporter ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'alamat': alamat,
      'tgl_daftar': tglDaftar,
      'no_telpon': noTelpon,
      'foto': foto,
    };
  }
}
