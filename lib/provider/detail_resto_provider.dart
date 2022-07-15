import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api_service/api_service.dart';
import 'package:restaurant_app/data/model/detail_resto.dart';
import 'package:restaurant_app/utils/state_result.dart';

class DetailRestoProvider extends ChangeNotifier {
  final ApiService apiService;
  final String resto;

  DetailRestoProvider({required this.apiService, required this.resto}) {
    _fetchDetailRestaurant();
  }

  late DetailResult _detailResult;
  late StateResult _state;
  String _message = '';

  DetailResult get detailResult => _detailResult;

  StateResult get state => _state;

  String get message => _message;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = StateResult.loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurant(resto);
      if (restaurant.restaurants == StateResult.noData) {
        _state = StateResult.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = StateResult.hasData;
        notifyListeners();
        return _detailResult = restaurant;
      }
    } catch (e) {
      _state = StateResult.error;
      notifyListeners();
      return _message =
          'Error --> Failed Load Data, please check your internet connection';
    }
  }
}
