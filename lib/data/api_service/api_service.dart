import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_resto.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';
  static const String _throw = 'Failed load data';

  Future<RestoResult> listRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return RestoResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }

  Future<DetailResult> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + '$id'));
    if (response.statusCode == 200) {
      return DetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }

  Future<RestoSearch> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + query));
    if (response.statusCode == 200) {
      return RestoSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }
}
