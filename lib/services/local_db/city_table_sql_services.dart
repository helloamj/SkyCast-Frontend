import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skycast/controllers/search_city_providers.dart';
import 'package:skycast/helpers/sql_helper/sql_helper.dart';
import 'package:skycast/models/city_model.dart';
import 'package:sqflite/sqflite.dart';

class CitySqlService {
  static late final DatabaseHelper dbHelper;
  static const String _tableName = 'CityTable';

  // Create the database table with the specified schema
  static Future<void> createTable() async {
    const tableSchema = '''
      id TEXT PRIMARY KEY,
      name TEXT,
      lat REAL,
      lon REAL,
      country TEXT,
      state TEXT
    ''';
    await dbHelper.createTable(_tableName, tableSchema);
  }

  // Insert a city into the database table if it doesn't exist
  static Future<void> insertCity(CityModel city) async {
    await dbHelper.insertItem(_tableName, city.toJson());
  }

  // Update a city in the database table
  static Future<void> updateCity(CityModel city) async {
    await dbHelper.updateItem(
      _tableName,
      city.toJson(),
      'id = ?',
      [city.id],
    );
  }

  // Retrieve all cities from the database
  static Future<List<CityModel>> getAllCities() async {
    log('Getting all cities from the database');
    List<CityModel> cities = [];
    cities = await dbHelper.getAllItemsTyped<CityModel>(
        _tableName, CityModel.fromJson);
    log('Cities: $cities');
    return cities.reversed.toList();
  }

  // Delete a city from the database table
  static Future<void> deleteCity(String id) async {
    await dbHelper.deleteItem(_tableName, 'id = ?', [id]);
  }
}
