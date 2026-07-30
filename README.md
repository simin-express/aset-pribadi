# Aset Rumah App — Starter Project

Kode awal aplikasi pencatat aset kendaraan & barang rumah, dibuat dengan Flutter + SQLite (data tersimpan lokal di HP, tidak perlu internet atau akun).

## Fitur yang sudah jalan di starter ini
- Tambah aset baru (nama, kategori, nomor plat/seri, tanggal beli, catatan)
- Lihat daftar semua aset
- Data tersimpan permanen di HP

## Cara Pakai

### 1. Buat project Flutter baru (kalau belum ada)
```
flutter create aset_rumah_app
cd aset_rumah_app
```

### 2. Tambahkan dependency
Buka file `pubspec.yaml` di project kamu, tambahkan di bagian `dependencies`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  path: ^1.8.3
```
Lalu jalankan:
```
flutter pub get
```

### 3. Salin file-file ini ke project kamu
Struktur folder `lib/` di project Flutter kamu harus jadi seperti ini:
```
lib/
  main.dart
  models/
    asset.dart
    reminder.dart
  database/
    database_helper.dart
  screens/
    home_screen.dart
    add_asset_screen.dart
```
Salin isi tiap file yang sudah dibuat ke lokasi yang sama persis di project kamu (timpa `lib/main.dart` yang default).

### 4. Jalankan
Colokkan HP Android (aktifkan USB debugging) atau pakai emulator, lalu:
```
flutter run
```
Coba tekan tombol `+` di pojok kanan bawah untuk menambah aset pertama kamu.

## Struktur Data
- **Tabel `aset`**: menyimpan data aset (nama, kategori, nomor, tanggal beli, catatan)
- **Tabel `pengingat`**: modelnya (`reminder.dart`) dan fungsi CRUD-nya (`database_helper.dart`) sudah siap, tapi layar/UI-nya belum dibuat — ini jadi langkah selanjutnya

## Langkah Selanjutnya (biar makin lengkap)
1. **Layar Tambah Pengingat** — buat mirip `add_asset_screen.dart`, tapi hubungkan ke tabel `pengingat` (pilih aset, jenis pengingat, tanggal jatuh tempo)
2. **Notifikasi** — tambahkan package `flutter_local_notifications`, jadwalkan notifikasi beberapa hari sebelum tanggal jatuh tempo
3. **Edit & Hapus aset** — tambahkan tombol edit/hapus di `home_screen.dart`, panggil `updateAsset()` / `hapusAsset()` yang sudah ada di `database_helper.dart`
4. **Foto aset** — pakai package `image_picker` untuk ambil foto dari kamera/galeri
5. **Dashboard ringkasan** — tampilkan daftar pengingat yang paling mendekati jatuh tempo di halaman utama

## Kalau Ada Error
- `sqflite` tidak jalan di Chrome/web — jalankan di Android/iOS beneran (emulator atau HP fisik)
- Kalau muncul error "no such table" setelah ubah struktur database, hapus dulu aplikasinya dari HP/emulator lalu `flutter run` ulang (versi database masih 1, belum ada migrasi)
