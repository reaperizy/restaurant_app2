import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api_service/api_service.dart';
import 'package:restaurant_app/data/model/search.dart';
import 'package:restaurant_app/utils/state_result.dart';

class SearchRestoProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestoProvider({required this.apiService}) {
    fetchQueryRestaurant(query);
  }

  RestoSearch? _restaurantList;
  StateResult? _state;
  String _message = '';
  String _query = '';

  String get message => _message;

  String get query => _query;

  RestoSearch? get result => _restaurantList;

  StateResult? get state => _state;

  Future<dynamic> fetchQueryRestaurant(String query) async {
    try {
      if (query.isNotEmpty) {
        _state = StateResult.loading;
        _query = query;
        notifyListeners();
        final restaurantList = await apiService.searchRestaurant(query);
        if (restaurantList.restaurants.isEmpty) {
          _state = StateResult.noData;
          notifyListeners();
          return _message =
              'Oops, Restaurant atau Makanan yang kamu minta tidak ada :(';
        } else {
          _state = StateResult.hasData;
          notifyListeners();
          return _restaurantList = restaurantList;
        }
      }
    } catch (e) {
      _state = StateResult.error;
      notifyListeners();
      return _message =
          'Error --> Failed Load Data, please check your internet connection';
    }
  }
}
