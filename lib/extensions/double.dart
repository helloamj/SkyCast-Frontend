// This extension converts meters per second (m/s) to kilometers per hour (km/h).
// m/s is the default unit for wind speed in openweathermap, but we need to convert it to km/h.
extension ConvertWindSpeed on double {
  String get kmh => (this * 3.6).toStringAsFixed(2);
}

// This extension converts Kelvin temperature to Celsius temperature.
extension ConvertKelvinToCelsius on double {
  int get celsius => (this - 273.15).round();
}
