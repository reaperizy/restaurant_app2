import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/utils/state_result.dart';
import 'package:restaurant_app/widgets/resto_card.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String queries = '';
  final TextEditingController _searchControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Cari Restaurant Favoritmu',
                style: TextStyle(color: Colors.black))),
        body: SafeArea(
          child: Column(children: [
            _searchBar(),
            const SizedBox(height: 8),
            Expanded(
              child:
                  Consumer<SearchRestoProvider>(builder: (context, state, _) {
                if (state.state == StateResult.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.state == StateResult.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.result!.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = state.result!.restaurants[index];
                        return RestoCard(restaurant: restaurant);
                      });
                } else if (state.state == StateResult.noData) {
                  return Center(child: Text(state.message));
                } else if (state.state == StateResult.error) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text(''));
                }
              }),
            )
          ]),
        ));
  }

  Widget _searchBar() {
    return Consumer<SearchRestoProvider>(builder: (context, state, _) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6.0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: TextField(
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: "Mau pilih restaurant dan makanan dimana nih?",
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintStyle: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
              maxLines: 1,
              controller: _searchControl,
              onChanged: (String query) {
                if (query.isNotEmpty) {
                  setState(() {
                    queries = query;
                  });
                  state.fetchQueryRestaurant(query);
                }
              },
            ),
          ),
        ),
      );
    });
  }
}
