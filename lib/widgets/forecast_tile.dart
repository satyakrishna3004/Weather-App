import 'package:flutter/material.dart';
import '../data/models/forecast.dart';
import 'weather_icon.dart';
import 'package:intl/intl.dart';

class ForecastTile extends StatelessWidget {
  final ForecastItem item;
  const ForecastTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final day = DateFormat('E, MMM d').format(item.time);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            WeatherIcon(code: item.icon, size: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(item.main),
                ],
              ),
            ),
            Text(
              '${item.tempMin.toStringAsFixed(0)}° / ${item.tempMax.toStringAsFixed(0)}°',
            ),
          ],
        ),
      ),
    );
  }
}
