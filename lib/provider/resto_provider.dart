import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api_service/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/state_result.dart';

class RestoProvider extends ChangeNotifier {
  final ApiService apiService;

  RestoProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestoResult _restaurantResult;
  late StateResult _state;
  String _message = '';

  RestoResult get result => _restaurantResult;

  StateResult get state => _state;

  String get message => _message;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = StateResult.loading;
      notifyListeners();
      final restaurant = await apiService.listRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = StateResult.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = StateResult.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = StateResult.error;
      notifyListeners();
      return _message =
          'Error --> Failed Load Data, please check your internet connection';
    }
  }
}
