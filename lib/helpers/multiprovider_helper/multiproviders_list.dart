import 'package:provider/provider.dart';
import 'package:skycast/controllers/search_city_providers.dart';
import 'package:provider/single_child_widget.dart';

class MultiprovidersList {
  // List of providers used in the application
  static List<SingleChildWidget> providers = [
    // Provider for SearchCityProvider, which is a ChangeNotifier
    ChangeNotifierProvider<SearchCityProvider>(
        create: (_) => SearchCityProvider()),

    // Provider for SearchBoxProvider, which is a ChangeNotifier
    ChangeNotifierProvider<SearchBoxProvider>(
        create: (_) => SearchBoxProvider()),
  ];
}
