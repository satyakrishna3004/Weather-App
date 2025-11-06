import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/city.dart';

class FavoritesService {
  static const _key = 'favorite_cities_v1';

  Future<List<City>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    return raw.map((s) => City.fromGeoJson(jsonDecode(s))).toList();
  }

  Future<void> save(List<City> cities) async {
    final prefs = await SharedPreferences.getInstance();
    final list = cities.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(_key, list);
  }
}
