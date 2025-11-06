class ForecastItem {
  final DateTime time;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String icon;
  final String main;

  ForecastItem({
    required this.time,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.icon,
    required this.main,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final weather = (json['weather'] as List).first;
    return ForecastItem(
      time: DateTime.parse(json['dt_txt']),
      temp: (main['temp'] as num).toDouble(),
      tempMin: (main['temp_min'] as num).toDouble(),
      tempMax: (main['temp_max'] as num).toDouble(),
      icon: weather['icon'] ?? '01d',
      main: weather['main'] ?? '',
    );
  }
}

class Forecast {
  final String city;
  final String country;
  final List<ForecastItem> items;

  Forecast({required this.city, required this.country, required this.items});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final city = json['city'];
    final list = (json['list'] as List)
        .map((e) => ForecastItem.fromJson(e))
        .toList();
    return Forecast(
      city: city['name'] ?? '',
      country: city['country'] ?? '',
      items: list,
    );
  }
}
