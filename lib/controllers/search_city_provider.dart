import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skycast/models/city_model.dart';
import 'package:skycast/services/search_services.dart';

class SearchBoxProvider extends ChangeNotifier {
  bool _isFocused = false;

  bool get isFocused => _isFocused;

  set isFocused(bool value) {
    _isFocused = value;
    notifyListeners();
  }
}

class SearchCityProvider extends ChangeNotifier {
  List<CityModel> _cities = [];
  bool _isLoading = false;
  bool _isSearchingEmpty = true;

  bool get isSearchingEmpty => _isSearchingEmpty;
  bool get isLoading => _isLoading;

  List<CityModel> get cities => _cities;

  set isSearchingEmpty(bool value) {
    _isSearchingEmpty = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // dispose
  @override
  void dispose() {
    _cities = [];
    _isSearchingEmpty = true;
    _isLoading = false;
    super.dispose();
  }

  Future<void> searchCity(String query) async {
    if (query.isNotEmpty) {
      isSearchingEmpty = false;
      isLoading = true;
      _cities = await SearchServices.getSuggestions(query);
      isLoading = false;
      log('Cities: $_cities, $isSearchingEmpty');
    } else {
      isSearchingEmpty = true;
      _cities = [];
    }
    notifyListeners();
  }
}
