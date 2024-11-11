import 'package:sapu/models/user_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  // Menginisialisasi database
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Inisialisasi database
    _database = await _initDatabase();
    return _database!;
  }

  // Membuka database dan membuat tabel jika belum ada
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'student_data.db');
    return openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          address TEXT,
          education TEXT,
          nis TEXT,
          nisn TEXT,
          plateNumber TEXT,
          village TEXT,
          pdb TEXT,
          ward TEXT,
          subDistrict TEXT,
          rt TEXT,
          rw TEXT,
          namefather TEXT,
          namemother TEXT,
          nohp TEXT,
          closetcontact TEXT
        )
      ''');
    }, version: 1);
  }

  // Menambahkan data user
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Mengambil semua data user
  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  // Mengambil data user berdasarkan id
  Future<User?> getUserById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  //edit
  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

// delete
  Future<void> deleteData(int? id) async {
    if (id != null) {
      final db = await database;
      await db.delete(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );
    } else {
      print('ID tidak valid');
    }
  }
}
