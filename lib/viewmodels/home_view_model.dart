import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../core/result.dart';
import '../data/models/city.dart';
import '../data/models/weather.dart';
import '../data/repositories/weather_repository.dart';
import '../services/favorites_service.dart';
import 'settings_view_model.dart';

class HomeViewModel extends ChangeNotifier {
  final WeatherRepository repo;
  final FavoritesService favSvc;
  final SettingsViewModel settings;

  List<City> favorites = [];
  Weather? currentLocationWeather;
  String? error;
  bool loading = false;

  HomeViewModel(this.repo, this.favSvc, this.settings);

  Future<void> loadFavorites() async {
    favorites = await favSvc.load();
    notifyListeners();
  }

  Future<void> addFavorite(City c) async {
    if (!favorites.any((x) => x.name == c.name && x.country == c.country)) {
      favorites.add(c);
      await favSvc.save(favorites);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(City c) async {
    favorites.removeWhere((x) => x.name == c.name && x.country == c.country);
    await favSvc.save(favorites);
    notifyListeners();
  }

  Future<void> loadCurrentLocationWeather() async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        perm = await Geolocator.requestPermission();
      }

      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        loading = false;
        error = 'Location permission denied';
        notifyListeners();
        return;
      }

      final pos = await Geolocator.getCurrentPosition();
      final res = await repo.currentByLatLon(
        pos.latitude,
        pos.longitude,
        units: settings.unitsQuery,
      );

      if (res is Success<Weather>) {
        currentLocationWeather = res.data;
      } else if (res is Failure) {
        error = (res as Failure).message;
      }
    } catch (e) {
      error = 'Failed to get location weather';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
