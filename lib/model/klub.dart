class Club {
  dynamic id;
  String namaKlub;
  String tglBerdiri;
  dynamic kondisiKlub;
  dynamic kotaKlub;
  dynamic peringkat;
  dynamic hargaKlub;

  Club({
    required this.id,
    required this.namaKlub,
    required this.tglBerdiri,
    required this.kondisiKlub,
    required this.kotaKlub,
    required this.peringkat,
    required this.hargaKlub,
  });

  // Method untuk membuat objek Club dari JSON
  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'],
      namaKlub: json['nama_klub'] as String,
      tglBerdiri: json['tgl_berdiri'] as String,
      kondisiKlub: json['kondisi_klub'],
      kotaKlub: json['kota_klub'],
      peringkat: json['peringkat'],
      hargaKlub: json['harga_klub'],
    );
  }

  // Method untuk mengkonversi objek Club ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_klub': namaKlub,
      'tgl_berdiri': tglBerdiri,
      'kondisi_klub': kondisiKlub,
      'kota_klub': kotaKlub,
      'peringkat': peringkat,
      'harga_klub': hargaKlub.toString(),
    };
  }
}
