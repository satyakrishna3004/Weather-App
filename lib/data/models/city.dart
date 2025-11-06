class City {
  final String name;
  final String country;
  final double lat;
  final double lon;

  City({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory City.fromGeoJson(Map<String, dynamic> json) => City(
    name: json['name'] ?? '',
    country: json['country'] ?? '',
    lat: (json['lat'] as num).toDouble(),
    lon: (json['lon'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'country': country,
    'lat': lat,
    'lon': lon,
  };
}
