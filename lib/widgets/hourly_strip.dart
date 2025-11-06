import 'package:flutter/material.dart';
import '../data/models/forecast.dart';
import 'weather_icon.dart';
import 'package:intl/intl.dart';

class HourlyStrip extends StatelessWidget {
  final List<ForecastItem> items;
  const HourlyStrip({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final it = items[i];
          return Container(
            width: 90,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat('ha').format(it.time)),
                const SizedBox(height: 8),
                WeatherIcon(code: it.icon, size: 40),
                const SizedBox(height: 6),
                Text('${it.temp.toStringAsFixed(0)}°'),
              ],
            ),
          );
        },
      ),
    );
  }
}
