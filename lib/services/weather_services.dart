import 'dart:developer';

import 'package:skycast/constants/api_constants.dart';
import 'package:skycast/helpers/api_helper/api_helper.dart';
import 'package:skycast/models/city_model.dart';
import 'package:skycast/models/weather_report_model.dart';

class WeatherServices {
  // This method retrieves the weather report for a given city.
  static Future<WeatherReportModel> getWeatherReport(CityModel city) async {
    // Make an API call to fetch the weather report using the city's latitude and longitude.
    final response = await ApiHelper.get(ApiConstants.weatherAPI, queryParams: {
      'lat': city.lat.toString(),
      'lon': city.lon.toString(),
    });

    // Log the API response for debugging purposes.
    log(response.toString());

    // Convert the API response into a WeatherReportModel object.
    return WeatherReportModel.fromJson(response);
  }
}
