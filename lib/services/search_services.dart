import 'package:skycast/constants/api_constants.dart';
import 'package:skycast/helpers/api_helper/api_helper.dart';
import 'package:skycast/models/city_model.dart';

class SearchServices {
  static Future<List<CityModel>> getSuggestions(String query) async {
    final List<CityModel> cities = [];
    final response =
        await ApiHelper.get(ApiConstants.searchCityAPI, queryParams: {
      'q': query,
      'limit': '10',
    });
    if (response != null) {
      for (final city in response) {
        cities.add(CityModel.fromJson(city));
      }
    }
    return cities;
  }
}
