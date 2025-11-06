import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String code;
  final double size;
  const WeatherIcon({super.key, required this.code, this.size = 48});

  @override
  Widget build(BuildContext context) {
    final url = 'https://openweathermap.org/img/wn/${code}@2x.png';
    return Image.network(url, width: size, height: size, fit: BoxFit.contain);
  }
}
