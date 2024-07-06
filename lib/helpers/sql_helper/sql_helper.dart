import 'dart:developer';

import 'package:skycast/services/local_db/city_table_sql_services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  static late final Database instance;

  // Initialize the database
  static Future<void> init({
    required String dbName, // Name of the database
    required int version, // Version of the database
  }) async {
    print('Database is about to be created');
    try {
      final String path = join(await getDatabasesPath(),
          'skycast_db.db'); // Get the path where the database will be stored
      log('Database path: $path');
      instance = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          log('Creating database');
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          log('Database upgraded from $oldVersion to $newVersion');
        },
        singleInstance: true,
      );
      CitySqlService.dbHelper = DatabaseHelper(
          instance); // Set the database instance for the CitySqlService
      await CitySqlService.createTable(); // Create the table for CitySqlService
      log('Database created successfully!');
    } catch (e) {
      print('Error while initializing database: $e');
    }
  }
}

class DatabaseHelper {
  final Database database;

  DatabaseHelper(this.database);

  // Create a table in the database
  Future<void> createTable(String tableName, String tableSchema) async {
    await database
        .execute('CREATE TABLE IF NOT EXISTS $tableName ($tableSchema)');
  }

  // Check if a table exists in the database
  Future<bool> isTableExists(String tableName) async {
    var result = await database.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    return result.isNotEmpty;
  }

  // Insert an item into a table
  Future<int> insertItem(String tableName, Map<String, dynamic> values) async {
    return await database.insert(
      tableName,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update an item in a table
  Future<int> updateItem(String tableName, Map<String, dynamic> values,
      String whereClause, List<dynamic> whereArgs) async {
    return await database.update(tableName, values,
        where: whereClause, whereArgs: whereArgs);
  }

  // Delete an item from a table
  Future<int> deleteItem(
      String tableName, String whereClause, List<dynamic> whereArgs) async {
    return await database.delete(tableName,
        where: whereClause, whereArgs: whereArgs);
  }

  // Get all items from a table
  Future<List<Map<String, dynamic>>> getAllItems(String tableName) async {
    return await database.query(tableName);
  }

  // Get all items from a table and convert them to a typed list
  Future<List<T>> getAllItemsTyped<T>(
      String tableName, T Function(Map<String, dynamic>) fromMap) async {
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    return List.generate(maps.length, (i) => fromMap(maps[i]));
  }

  // Execute a custom query on the database
  Future<void> executeCustomQuery(String query,
      [List<dynamic>? arguments]) async {
    await database.rawQuery(query, arguments);
  }
}
