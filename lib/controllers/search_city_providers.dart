import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skycast/models/city_model.dart';
import 'package:skycast/services/local_db/city_table_sql_services.dart';
import 'package:skycast/services/search_services.dart';

// Provider class for managing the state of the search box
class SearchBoxProvider extends ChangeNotifier {
  bool _isFocused = false;

  bool get isFocused => _isFocused;

  set isFocused(bool value) {
    _isFocused = value;
    notifyListeners();
  }
}

// Provider class for managing the state of city search
class SearchCityProvider extends ChangeNotifier {
  List<CityModel> _cities = []; // List of cities
  bool _isLoading = false; // Flag to indicate if data is being loaded
  bool _isSearchingEmpty = true; // Flag to indicate if the search is empty

  bool get isSearchingEmpty =>
      _isSearchingEmpty; // Getter for _isSearchingEmpty
  bool get isLoading => _isLoading; // Getter for _isLoading

  List<CityModel> get cities => _cities; // Getter for _cities

  set cities(List<CityModel> value) {
    _cities = value;
    notifyListeners();
  }

  // Method to handle empty search
  Future<void> emptySearch(bool value) async {
    if (value) {
      _cities = await CitySqlService
          .getAllCities(); // Retrieve all cities from local database
    }
    _isSearchingEmpty = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Dispose method to clean up resources
  @override
  void dispose() {
    _cities = [];
    _isSearchingEmpty = true;
    _isLoading = false;
    super.dispose();
  }

  // Method to search for cities based on the query
  Future<void> searchCity(String query) async {
    if (query.isNotEmpty) {
      emptySearch(false); // Clear previous search results
      isLoading =
          true; // Set isLoading to true to indicate data is being loaded
      _cities = await SearchServices.getSuggestions(
          query); // Retrieve city suggestions based on the query
      isLoading = false; // Set isLoading to false as data loading is complete
      log('Cities: $_cities, $isSearchingEmpty'); // Log the retrieved cities and the value of isSearchingEmpty
    } else {
      emptySearch(true); // If the query is empty, set isSearchingEmpty to true
    }
    notifyListeners();
  }
}
