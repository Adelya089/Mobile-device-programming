
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LikesDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();

    _database = await openDatabase(
      join(dbPath, 'likes.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE likes (
            id TEXT PRIMARY KEY
          )
        ''');
      },
    );

    return _database!;
  }

  Future<List<String>> loadLikes() async {
    final db = await database;
    final rows = await db.query('likes');

    return rows
        .map((row) => row['id'] as String)
        .toList();
  }

  Future<void> toggleLike(String id) async {
    final db = await database;

    await db.transaction((txn) async {
      final rows = await txn.query(
        'likes',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (rows.isEmpty) {
        await txn.insert('likes', {'id': id});
      } else {
        await txn.delete(
          'likes',
          where: 'id = ?',
          whereArgs: [id],
        );
      }
    });
  }
}
