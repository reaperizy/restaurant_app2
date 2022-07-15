import 'package:restaurant_app/data/model/restaurant.dart';

class RestoSearch {
  RestoSearch({
    required this.restaurants,
  });

  List<Restaurant> restaurants;

  factory RestoSearch.fromJson(Map<String, dynamic> json) => RestoSearch(
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}
