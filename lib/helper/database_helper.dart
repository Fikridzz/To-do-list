import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list/data/to_do_data.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "to_do_list";

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}to_do_list.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title STRING, date STRING, isDone BOOLEAN "
          ")",
        );
      });
    } catch (e) {
      print('error $e');
    }
  }

  static Future<int> insert(ToDoData task) async {
    return await _db!.insert(_tableName, task.toMap());
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static delete(ToDoData task) async {
    await _db!.delete(_tableName, where: "id=?", whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
    UPDATE to_do_list
    SET isDone = ?
    WHERE id = ?
    ''', [1, id]);
  }

  static Future<List<Map<String, dynamic>>> search(String value) async {
    return await _db!.query(_tableName, where: "title LIKE '%$value%'");
  }
}
