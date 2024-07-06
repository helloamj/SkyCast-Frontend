import 'dart:convert';

// Function to convert JSON string to CityModel object
CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

// Function to convert CityModel object to JSON string
String cityModelToJson(CityModel data) => json.encode(data.toJson());

// CityModel class representing a city
class CityModel {
  String id; // Unique identifier for the city
  String name; // Name of the city
  double lat; // Latitude coordinate of the city
  double lon; // Longitude coordinate of the city
  String country; // Country where the city is located
  String state; // State where the city is located

  // Constructor for CityModel class
  CityModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  // Factory method to create a CityModel object from a JSON map
  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["lat"].toString() +
            json["lon"].toString(), // Concatenate lat and lon to create the id
        name: json["name"], // Get the name from the JSON map
        lat: json["lat"]
            ?.toDouble(), // Get the lat from the JSON map and convert it to double
        lon: json["lon"]
            ?.toDouble(), // Get the lon from the JSON map and convert it to double
        country: json["country"], // Get the country from the JSON map
        state: json["state"] ??
            '', // Get the state from the JSON map, if it's null, set it to an empty string
      );

  // Method to convert CityModel object to a JSON map
  Map<String, dynamic> toJson() => {
        "id": id, // Add the id to the JSON map
        "name": name, // Add the name to the JSON map
        "lat": lat, // Add the lat to the JSON map
        "lon": lon, // Add the lon to the JSON map
        "country": country, // Add the country to the JSON map
        "state": state, // Add the state to the JSON map
      };
}
