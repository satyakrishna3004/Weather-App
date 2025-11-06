import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mvvm/core/constants.dart';
import '../../viewmodels/home_view_model.dart';
import '../../viewmodels/settings_view_model.dart';
import '../../widgets/weather_icon.dart';
import '../../app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<HomeViewModel>();
      vm.loadFavorites();
      context.read<SettingsViewModel>().load();
      vm.loadCurrentLocationWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final settings = context.watch<SettingsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.favorites),
            icon: const Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.search),
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<String>(
            onSelected: (v) {
              switch (v) {
                case 'Celsius':
                  settings.setUnits(TempUnit.celsius, settings.speed);
                  break;
                case 'Fahrenheit':
                  settings.setUnits(TempUnit.fahrenheit, settings.speed);
                  break;
                case 'km/h':
                  settings.setUnits(settings.temp, SpeedUnit.kph);
                  break;
                case 'mph':
                  settings.setUnits(settings.temp, SpeedUnit.mph);
                  break;
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'Celsius', child: Text('Celsius')),
              PopupMenuItem(value: 'Fahrenheit', child: Text('Fahrenheit')),
              PopupMenuDivider(),
              PopupMenuItem(value: 'km/h', child: Text('km/h')),
              PopupMenuItem(value: 'mph', child: Text('mph')),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => vm.loadCurrentLocationWeather(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (vm.loading) const LinearProgressIndicator(),
            if (vm.currentLocationWeather != null) _CurrentCard(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Favorites',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.search),
                  child: const Text('Add'),
                ),
              ],
            ),
            if (vm.favorites.isEmpty)
              const Text('No favorites yet. Use search to add.'),
            for (final c in vm.favorites)
              Card(
                child: ListTile(
                  title: Text('${c.name}, ${c.country}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.detail,
                    arguments: c.name,
                  ),
                  onLongPress: () => vm.removeFavorite(c),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CurrentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final s = context.watch<SettingsViewModel>();
    final w = vm.currentLocationWeather!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your location',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                WeatherIcon(code: w.icon, size: 72),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${w.city}, ${w.country}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text('${s.formatTemp(w.temp)} • ${w.main}'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(label: Text('Feels ${s.formatTemp(w.feelsLike)}')),
                const SizedBox(width: 8),
                Chip(label: Text('Humidity ${w.humidity}%')),
                const SizedBox(width: 8),
                Chip(label: Text('Wind ${s.formatSpeed(w.windSpeedMs)}')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
