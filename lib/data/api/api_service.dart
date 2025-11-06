import 'package:dio/dio.dart';
import '../../core/constants.dart';
import '../../secrets.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<Response> getCurrentByCity(
    String city, {
    String units = 'metric',
  }) async {
    return _dio.get(
      Constants.weather,
      queryParameters: {'q': city, 'appid': kOpenWeatherApiKey, 'units': units},
    );
  }

  Future<Response> getCurrentByLatLon(
    double lat,
    double lon, {
    String units = 'metric',
  }) async {
    return _dio.get(
      Constants.weather,
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': kOpenWeatherApiKey,
        'units': units,
      },
    );
  }

  Future<Response> getForecastByCity(
    String city, {
    String units = 'metric',
  }) async {
    return _dio.get(
      Constants.forecast,
      queryParameters: {'q': city, 'appid': kOpenWeatherApiKey, 'units': units},
    );
  }

  Future<Response> getForecastByLatLon(
    double lat,
    double lon, {
    String units = 'metric',
  }) async {
    return _dio.get(
      Constants.forecast,
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': kOpenWeatherApiKey,
        'units': units,
      },
    );
  }

  /// OpenWeatherMap Geocoding for search suggestions
  Future<Response> geoDirect(String query, {int limit = 5}) async {
    return _dio.get(
      Constants.geoDirect,
      queryParameters: {
        'q': query,
        'limit': limit,
        'appid': kOpenWeatherApiKey,
      },
    );
  }
}
