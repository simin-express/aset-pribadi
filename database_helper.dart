import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/asset.dart';
import '../models/reminder.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('aset_rumah.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE aset (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        kategori TEXT NOT NULL,
        nomor_identitas TEXT,
        tanggal_beli TEXT NOT NULL,
        catatan TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE pengingat (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        asset_id INTEGER NOT NULL,
        jenis TEXT NOT NULL,
        tanggal_jatuh_tempo TEXT NOT NULL,
        interval TEXT NOT NULL,
        sudah_selesai INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (asset_id) REFERENCES aset (id) ON DELETE CASCADE
      )
    ''');
  }

  // ---- CRUD Aset ----
  Future<int> tambahAsset(Asset asset) async {
    final db = await instance.database;
    return await db.insert('aset', asset.toMap());
  }

  Future<List<Asset>> ambilSemuaAsset() async {
    final db = await instance.database;
    final result = await db.query('aset', orderBy: 'nama ASC');
    return result.map((map) => Asset.fromMap(map)).toList();
  }

  Future<int> updateAsset(Asset asset) async {
    final db = await instance.database;
    return await db.update(
      'aset',
      asset.toMap(),
      where: 'id = ?',
      whereArgs: [asset.id],
    );
  }

  Future<int> hapusAsset(int id) async {
    final db = await instance.database;
    return await db.delete('aset', where: 'id = ?', whereArgs: [id]);
  }

  // ---- CRUD Pengingat ----
  Future<int> tambahReminder(Reminder reminder) async {
    final db = await instance.database;
    return await db.insert('pengingat', reminder.toMap());
  }

  Future<List<Reminder>> ambilReminderByAsset(int assetId) async {
    final db = await instance.database;
    final result = await db.query(
      'pengingat',
      where: 'asset_id = ?',
      whereArgs: [assetId],
      orderBy: 'tanggal_jatuh_tempo ASC',
    );
    return result.map((map) => Reminder.fromMap(map)).toList();
  }

  Future<List<Reminder>> ambilSemuaReminderMendekati() async {
    final db = await instance.database;
    final result = await db.query(
      'pengingat',
      where: 'sudah_selesai = 0',
      orderBy: 'tanggal_jatuh_tempo ASC',
    );
    return result.map((map) => Reminder.fromMap(map)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
