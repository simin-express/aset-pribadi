class Reminder {
  final int? id;
  final int assetId;
  final String jenis; // pajak, servis, garansi, lainnya
  final DateTime tanggalJatuhTempo;
  final String interval; // sekali, bulanan, tahunan
  final bool sudahSelesai;

  Reminder({
    this.id,
    required this.assetId,
    required this.jenis,
    required this.tanggalJatuhTempo,
    this.interval = 'sekali',
    this.sudahSelesai = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'asset_id': assetId,
      'jenis': jenis,
      'tanggal_jatuh_tempo': tanggalJatuhTempo.toIso8601String(),
      'interval': interval,
      'sudah_selesai': sudahSelesai ? 1 : 0,
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      assetId: map['asset_id'],
      jenis: map['jenis'],
      tanggalJatuhTempo: DateTime.parse(map['tanggal_jatuh_tempo']),
      interval: map['interval'],
      sudahSelesai: map['sudah_selesai'] == 1,
    );
  }
}
