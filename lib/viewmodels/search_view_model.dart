import 'package:flutter/foundation.dart';
import '../core/debouncer.dart';
import '../core/result.dart';
import '../data/models/city.dart';
import '../data/repositories/weather_repository.dart';

class SearchViewModel extends ChangeNotifier {
  final WeatherRepository repo;
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 350));

  List<City> results = [];
  bool loading = false;
  String? error;

  SearchViewModel(this.repo);

  void onQueryChanged(String q) {
    if (q.trim().isEmpty) {
      results = [];
      error = null;
      notifyListeners();
      return;
    }

    loading = true;
    error = null;
    notifyListeners();

    _debouncer.run(() async {
      final res = await repo.searchCities(q);

      if (res is Success<List<City>>) {
        results = res.data;
        error = null;
      } else if (res is Failure) {
        results = [];
        error = (res as Failure).message;
      }

      loading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }
}
