import 'package:provider/provider.dart';
import 'package:skycast/controllers/search_city_providers.dart';
import 'package:provider/single_child_widget.dart';

class MultiprovidersList {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<SearchCityProvider>(
        create: (_) => SearchCityProvider()),
    ChangeNotifierProvider<SearchBoxProvider>(
        create: (_) => SearchBoxProvider()),
  ];
}
