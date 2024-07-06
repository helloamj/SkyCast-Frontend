import 'package:skycast/constants/api_constants.dart';
import 'package:skycast/helpers/api_helper/api_helper.dart';
import 'package:skycast/models/city_model.dart';

class SearchServices {
  // This method retrieves a list of city suggestions based on the given query.
  static Future<List<CityModel>> getSuggestions(String query) async {
    final List<CityModel> cities = [];

    // Make an API call to fetch the city suggestions.
    final response =
        await ApiHelper.get(ApiConstants.searchCityAPI, queryParams: {
      'q': query,
      'limit': '10',
    });

    // If the response is not null, iterate through the response and convert each city to a CityModel object.
    if (response != null) {
      for (final city in response) {
        cities.add(CityModel.fromJson(city));
      }
    }

    // Return the list of city suggestions.
    return cities;
  }
}
