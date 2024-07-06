import 'package:skycast/helpers/sql_helper/sql_helper.dart';

/// A class that contains constants related to the database.
class DbConstants {
  /// The name of the database.
  static const String dbName = 'app_database';

  /// The SQLite helper instance used to interact with the database.
  static late DatabaseHelper sqLiteHelper;

  /// The version of the database.
  static const int dbVersion = 1;
}
