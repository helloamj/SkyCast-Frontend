import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skycast/controllers/search_city_provider.dart';
import 'package:skycast/views/home_screen.dart';
import 'package:skycast/views/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchCityProvider()),
        ChangeNotifierProvider(create: (_) => SearchBoxProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SkyCast',
        theme: AppTheme.instance,
        home: MyHomePage(),
      ),
    );
  }
}
