// To parse this JSON data, do
//
//     final weatherReportModel = weatherReportModelFromJson(jsonString);

import 'dart:convert';

// WeatherReportModel class represents the weather report data
class WeatherReportModel {
  Coord coord; // Represents the coordinates of the location
  List<Weather> weather; // Represents the weather conditions
  String base; // Represents the data source
  Main main; // Represents the main weather parameters
  Wind wind; // Represents the wind information

  WeatherReportModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.wind,
  });

  // Factory method to create a WeatherReportModel instance from JSON data
  factory WeatherReportModel.fromJson(Map<String, dynamic> json) =>
      WeatherReportModel(
        coord: Coord.fromJson(json["coord"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        base: json["base"],
        main: Main.fromJson(json["main"]),
        wind: Wind.fromJson(json["wind"]),
      );

  // Converts WeatherReportModel instance to JSON data
  Map<String, dynamic> toJson() => {
        "coord": coord.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "base": base,
        "main": main.toJson(),
        "wind": wind.toJson(),
      };
}

// Coord class represents the coordinates of a location
class Coord {
  double lon; // Represents the longitude
  double lat; // Represents the latitude

  Coord({
    required this.lon,
    required this.lat,
  });

  // Factory method to create a Coord instance from JSON data
  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
      );

  // Converts Coord instance to JSON data
  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}

// Main class represents the main weather parameters
class Main {
  double temp; // Represents the temperature
  double feelsLike; // Represents the perceived temperature
  double tempMin; // Represents the minimum temperature
  double tempMax; // Represents the maximum temperature
  int pressure; // Represents the atmospheric pressure
  int humidity; // Represents the humidity

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  // Factory method to create a Main instance from JSON data
  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"],
        tempMax: json["temp_max"],
        pressure: json["pressure"],
        humidity: json["humidity"],
      );

  // Converts Main instance to JSON data
  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
      };
}

// Weather class represents the weather conditions
class Weather {
  int id; // Represents the weather condition ID
  String main; // Represents the main weather condition
  String description; // Represents the weather condition description
  String icon; // Represents the weather condition icon

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  // Factory method to create a Weather instance from JSON data
  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  // Converts Weather instance to JSON data
  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

// Wind class represents the wind information
class Wind {
  double speed; // Represents the wind speed

  Wind({
    required this.speed,
  });

  // Factory method to create a Wind instance from JSON data
  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
      );

  // Converts Wind instance to JSON data
  Map<String, dynamic> toJson() => {
        "speed": speed,
      };
}
