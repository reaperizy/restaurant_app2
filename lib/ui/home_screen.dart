import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/resto_provider.dart';
import 'package:restaurant_app/ui/search_screen.dart';
import 'package:restaurant_app/utils/state_result.dart';
import 'package:restaurant_app/widgets/resto_card.dart';

class HomeRestoScreen extends StatelessWidget {
  static const routeName = '/list_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 75,
        title: const Text('Mau makan dimana hari ini?',
            style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            icon: const Icon(Icons.search, color: Colors.brown),
          )
        ],
      ),
      body: Consumer<RestoProvider>(
        builder: (context, state, _) {
          if (state.state == StateResult.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (state.state == StateResult.hasData) {
              return Scaffold(
                body: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result.restaurants[index];
                    return RestoCard(restaurant: restaurant);
                  },
                ),
              );
            } else if (state.state == StateResult.noData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == StateResult.error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          }
        },
      ),
    );
  }
}
