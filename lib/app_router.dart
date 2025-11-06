import 'package:flutter/material.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/search_screen.dart';
import 'ui/screens/weather_detail_screen.dart';
import 'ui/screens/favorites_screen.dart';

class Routes {
  static const home = '/';
  static const search = '/search';
  static const detail = '/detail';
  static const favorites = '/favorites';
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case Routes.search:
      return MaterialPageRoute(builder: (_) => const SearchScreen());
    case Routes.favorites:
      return MaterialPageRoute(builder: (_) => const FavoritesScreen());
    case Routes.detail:
      final city = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => WeatherDetailScreen(city: city));
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(body: Center(child: Text('Not found'))),
      );
  }
}
