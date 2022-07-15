import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api_service/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail_resto_provider.dart';
import 'package:restaurant_app/utils/state_result.dart';
import 'package:restaurant_app/widgets/detail_page.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class DetailRestoScreen extends StatelessWidget {
  static const routeName = '/detail_screen';

  const DetailRestoScreen({required this.restaurant});

  final Restaurant restaurant;

  Widget _buildList(BuildContext context) {
    return ChangeNotifierProvider<DetailRestoProvider>(
      create: (_) =>
          DetailRestoProvider(apiService: ApiService(), resto: restaurant.id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Detail Restaurant',
              style: TextStyle(color: Colors.black)),
        ),
        body: Consumer<DetailRestoProvider>(builder: (context, data, _) {
          if (data.state == StateResult.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.state == StateResult.hasData) {
            return Scaffold(
              body: DetailRestoPage(restaurants: data.detailResult.restaurants),
            );
          } else if (data.state == StateResult.noData) {
            return Center(child: Text(data.message));
          } else if (data.state == StateResult.error) {
            return Center(child: Text(data.message));
          } else {
            return const Center(child: Text(''));
          }
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidbuilder: _buildList,
      iosbuilder: _buildList,
    );
  }
}
