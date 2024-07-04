import 'dart:developer';

import 'package:skycast/constants/api_constants.dart';
import 'package:skycast/helpers/api_helper/api_helper.dart';
import 'package:skycast/models/city_model.dart';
import 'package:skycast/models/weather_report_model.dart';

class WeatherServices {
  static Future<WeatherReportModel> getWeatherReport(CityModel city) async {
    final response = await ApiHelper.get(ApiConstants.weatherAPI, queryParams: {
      'lat': city.lat.toString(),
      'lon': city.lon.toString(),
    });
    log(response.toString());
    return WeatherReportModel.fromJson(response);
  }
}
