import 'dart:async';

import 'package:mc_application/core/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteUserService {
  // Tên của bảng trong cơ sở dữ liệu
  static const String tableName = 'user';

  // Tên các cột trong bảng
  static const String columnId = 'id';
  static const String columnUsername = 'username';
  static const String columnAccessToken = 'accessToken';

  // Đường dẫn và tên cơ sở dữ liệu
  static const String databaseName = 'nhom4.db';

  // Phiên bản cơ sở dữ liệu
  static const int databaseVersion = 1;

  // Khởi tạo và mở cơ sở dữ liệu
  static Future<Database> _openDatabase() async {
    final databasesPath = await getDatabasesPath();
    print('databasesPath $databasesPath');
    final path = join(databasesPath, databaseName);
    return await openDatabase(path, version: databaseVersion,
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $tableName (
          $columnId TEXT NOT NULL,
          $columnUsername TEXT NOT NULL,
          $columnAccessToken TEXT NOT NULL
        )
      ''');
    });
  }

  // Thêm dữ liệu vào bảng user
  static Future<int> insertUser(UserModel user) async {
    final db = await _openDatabase();
    final userMap = {
      columnUsername: user.username,
      columnAccessToken: user.accessToken,
    };
    return await db.insert(tableName, userMap);
  }

  // Lấy danh sách user từ bảng
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await _openDatabase();
    return await db.query(tableName);
  }

  // Cập nhật dữ liệu của một user
  static Future<int> updateUser(
      int id, String username, String accessToken) async {
    final db = await _openDatabase();
    final userMap = {
      columnId: id,
      columnUsername: username,
      columnAccessToken: accessToken,
    };
    return await db
        .update(tableName, userMap, where: '$columnId = ?', whereArgs: [id]);
  }

  // Xóa dữ liệu của một user
  static Future<int> deleteUser(int id) async {
    final db = await _openDatabase();
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
