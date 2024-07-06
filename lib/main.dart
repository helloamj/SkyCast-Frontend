import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skycast/helpers/multiprovider_helper/multiproviders_list.dart';
import 'package:skycast/helpers/sql_helper/db_constants.dart';
import 'package:skycast/helpers/sql_helper/sql_helper.dart';
import 'package:skycast/views/home/search_city_screen.dart';
import 'package:skycast/views/theme/theme.dart';

// The main function is the entry point of the application
Future<void> main() async {
  // Ensure that the Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the SQLite database
  SQLiteHelper.init(
    dbName: DbConstants.dbName,
    version: DbConstants.dbVersion,
  );

  // Run the app
  runApp(const MyApp());
}

// MyApp is the root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Use the MultiProvider widget to provide multiple providers to the app
      providers: MultiprovidersList.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SkyCast',
        theme: AppTheme.instance,
        home: SearchCityScreen(),
      ),
    );
  }
}
