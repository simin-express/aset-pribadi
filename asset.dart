class Asset {
  final int? id;
  final String nama;
  final String kategori;
  final String? nomorIdentitas; // plat nomor / nomor seri
  final DateTime tanggalBeli;
  final String? catatan;

  Asset({
    this.id,
    required this.nama,
    required this.kategori,
    this.nomorIdentitas,
    required this.tanggalBeli,
    this.catatan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'kategori': kategori,
      'nomor_identitas': nomorIdentitas,
      'tanggal_beli': tanggalBeli.toIso8601String(),
      'catatan': catatan,
    };
  }

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map['id'],
      nama: map['nama'],
      kategori: map['kategori'],
      nomorIdentitas: map['nomor_identitas'],
      tanggalBeli: DateTime.parse(map['tanggal_beli']),
      catatan: map['catatan'],
    );
  }
}
