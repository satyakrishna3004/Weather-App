import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/weather_icon.dart';
import '../../widgets/forecast_tile.dart';
import '../../widgets/hourly_strip.dart';
import '../../viewmodels/weather_detail_view_model.dart';
import '../../viewmodels/settings_view_model.dart';
import '../../viewmodels/home_view_model.dart';
import '../../data/models/city.dart';

class WeatherDetailScreen extends StatefulWidget {
  final String city;
  const WeatherDetailScreen({super.key, required this.city});
  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<WeatherDetailViewModel>().loadForCity(widget.city),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatherDetailViewModel>();
    final s = context.watch<SettingsViewModel>();
    final home = context.watch<HomeViewModel>();

    final isFav = home.favorites.any((x) => x.name == widget.city);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city),
        actions: [
          IconButton(
            onPressed: () => vm.loadForCity(widget.city),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
            onPressed: () {
              if (isFav) {
                final c = home.favorites.firstWhere(
                  (x) => x.name == widget.city,
                );
                home.removeFavorite(c);
              } else {
                home.addFavorite(
                  City(
                    name: widget.city,
                    country: vm.weather?.country ?? '',
                    lat: 0,
                    lon: 0,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: vm.loading
          ? const LinearProgressIndicator()
          : vm.weather == null
          ? Center(child: Text(vm.error ?? 'No data'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        WeatherIcon(code: vm.weather!.icon, size: 88),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${vm.weather!.city}, ${vm.weather!.country}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${s.formatTemp(vm.weather!.temp)} • ${vm.weather!.main}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      label: Text(
                        'Feels ${s.formatTemp(vm.weather!.feelsLike)}',
                      ),
                    ),
                    Chip(label: Text('Humidity ${vm.weather!.humidity}%')),
                    Chip(
                      label: Text(
                        'Wind ${s.formatSpeed(vm.weather!.windSpeedMs)}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (vm.next24h().isNotEmpty) ...[
                  const Text(
                    'Hourly (next 24h)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  HourlyStrip(items: vm.next24h()),
                  const SizedBox(height: 8),
                ],
                const SizedBox(height: 8),
                const Text(
                  '5-Day Forecast',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                for (final it in vm.dailyFive()) ForecastTile(item: it),
              ],
            ),
    );
  }
}
