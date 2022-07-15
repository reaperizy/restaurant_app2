import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detailresto_screen.dart';
import 'package:restaurant_app/ui/error_screen.dart';
import 'package:restaurant_app/ui/home_screen.dart';
import 'package:restaurant_app/ui/splash_screen.dart';
import 'package:restaurant_app/data/api_service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/resto_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestoProvider>(
          create: (_) => RestoProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<SearchRestoProvider>(
          create: (_) => SearchRestoProvider(apiService: ApiService()),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(elevation: 0),
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.black,
                secondary: secondaryColor,
              ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          HomeRestoScreen.routeName: (context) => HomeRestoScreen(),
          DetailRestoScreen.routeName: (context) => DetailRestoScreen(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant),
          ErrorScreen.routeName: (context) => ErrorScreen(),
        },
      ),
    );
  }
}
