class Weather {
  final String city;
  final String country;
  final double temp;
  final double feelsLike;
  final int humidity;
  final double windSpeedMs;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.city,
    required this.country,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeedMs,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final w = (json['weather'] as List).first;
    return Weather(
      city: json['name'] ?? '',
      country: json['sys']?['country'] ?? '',
      temp: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: (json['main']['humidity'] as num).toInt(),
      windSpeedMs: (json['wind']['speed'] as num).toDouble(),
      main: w['main'] ?? '',
      description: w['description'] ?? '',
      icon: w['icon'] ?? '01d',
    );
  }
}
