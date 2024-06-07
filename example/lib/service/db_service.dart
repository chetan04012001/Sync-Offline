import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;
  static DBHelper? _dbHelper;

  DBHelper._privateConstructor();

  factory DBHelper() {
    _dbHelper ??= DBHelper._privateConstructor();
    return _dbHelper!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'PostDatabase.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE posts(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT, job TEXT, email TEXT, mobile TEXT, address TEXT, status INTEGER)',
        );
      },
      version: 1,
    );
    return database;
  }

  Future<int> insertData(String name, String job, String email, String mobile,
      String address) async {
    final Database db = await database;
    int? id = await db.insert(
      'posts',
      {
        'name': name,
        'job': job,
        'email': email,
        'mobile': mobile,
        'address': address,
        'status': 1, // 1 means data is not synced with the server
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (id != null) {
      return id;
    } else {
      throw Exception("Failed to Insert data");
    }
  }

  Future<Map<String, dynamic>?> getDataById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'posts',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<List<Map>> getAllData() async {
    final Database db = await database;
    var result = await db.query("posts",
        columns: ["id", "name", "job", "email", "mobile", "address", "status"]);

    return result.toList();
  }

  Future<int?> getMostRecentEntryId() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT MAX(id) as id FROM posts
    ''');
    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getUnsyncedData() async {
    final Database db = await database;
    return db.query('posts', where: 'status = ?', whereArgs: [1]);
  }

  Future<List<Map<String, dynamic>>> getUnsyncedDataForId(int id) async {
    final Database db = await database;
    return db
        .query('posts', where: 'id = ? AND status = ?', whereArgs: [id, 1]);
  }

  Future<void> updateStatus(int id, int status) async {
    final Database db = await database;
    await db.update(
      'posts',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
