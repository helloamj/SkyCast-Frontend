import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skycast/helpers/fluttertoast_helper/fluttertoast_helper.dart';
import 'package:skycast/helpers/multiprovider_helper/multiproviders_list.dart';
import 'package:skycast/views/home/search_city_screen.dart';
import 'package:skycast/views/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
