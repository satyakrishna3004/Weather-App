import 'package:flutter/foundation.dart';
import '../core/result.dart';
import '../data/models/forecast.dart';
import '../data/models/weather.dart';
import '../data/repositories/weather_repository.dart';
import 'settings_view_model.dart';

class WeatherDetailViewModel extends ChangeNotifier {
  final WeatherRepository repo;
  final SettingsViewModel settings;

  Weather? weather;
  Forecast? forecast;
  String? error;
  bool loading = false;

  WeatherDetailViewModel(this.repo, this.settings);

  Future<void> loadForCity(String city) async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      final w = await repo.currentByCity(city, units: settings.unitsQuery);
      if (w is Success<Weather>) {
        weather = w.data;
      } else if (w is Failure) {
        error = (w as Failure).message;
      }

      final f = await repo.forecastByCity(city, units: settings.unitsQuery);
      if (f is Success<Forecast>) {
        forecast = f.data;
      } else if (f is Failure) {
        error = (f as Failure).message;
      }
    } catch (_) {
      error = 'Unable to load weather';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  List<ForecastItem> dailyFive() {
    if (forecast == null) return [];

    final Map<String, ForecastItem> byDay = {};
    for (final it in forecast!.items) {
      final key = '${it.time.year}-${it.time.month}-${it.time.day}';
      if (!byDay.containsKey(key) || it.time.hour == 12) {
        byDay[key] = it;
      }
    }
    final list = byDay.values.toList()
      ..sort((a, b) => a.time.compareTo(b.time));
    return list.take(5).toList();
  }

  List<ForecastItem> next24h() {
    if (forecast == null) return [];
    final now = DateTime.now();
    return forecast!.items.where((e) => e.time.isAfter(now)).take(8).toList();
  }
}
