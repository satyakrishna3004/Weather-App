import 'package:dio/dio.dart';
import '../../core/result.dart';
import '../api/api_service.dart';
import '../models/city.dart';
import '../models/weather.dart';
import '../models/forecast.dart';

class WeatherRepository {
  final ApiService api;
  WeatherRepository(this.api);

  Future<Result<List<City>>> searchCities(String query) async {
    try {
      final res = await api.geoDirect(query);
      final data = (res.data as List).map((e) => City.fromGeoJson(e)).toList();
      if (data.isEmpty) return Failure('No matching cities');
      return Success(data);
    } catch (e) {
      return Failure(_err(e));
    }
  }

  Future<Result<Weather>> currentByCity(
    String city, {
    String units = 'metric',
  }) async {
    try {
      final res = await api.getCurrentByCity(city, units: units);
      return Success(Weather.fromJson(res.data));
    } catch (e) {
      return Failure(_err(e));
    }
  }

  Future<Result<Weather>> currentByLatLon(
    double lat,
    double lon, {
    String units = 'metric',
  }) async {
    try {
      final res = await api.getCurrentByLatLon(lat, lon, units: units);
      return Success(Weather.fromJson(res.data));
    } catch (e) {
      return Failure(_err(e));
    }
  }

  Future<Result<Forecast>> forecastByCity(
    String city, {
    String units = 'metric',
  }) async {
    try {
      final res = await api.getForecastByCity(city, units: units);
      return Success(Forecast.fromJson(res.data));
    } catch (e) {
      return Failure(_err(e));
    }
  }

  String _err(Object e) {
    if (e is DioException) {
      return e.response?.data is Map && (e.response?.data['message'] != null)
          ? e.response!.data['message']
          : e.message ?? 'Network error';
    }
    return 'Something went wrong';
  }
}
