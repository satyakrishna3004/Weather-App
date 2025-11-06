import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'theme/app_theme.dart';
import 'data/api/api_service.dart';
import 'data/repositories/weather_repository.dart';
import 'services/favorites_service.dart';
import 'services/settings_service.dart';
import 'viewmodels/home_view_model.dart';
import 'viewmodels/search_view_model.dart';
import 'viewmodels/settings_view_model.dart';
import 'viewmodels/weather_detail_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final api = ApiService();
  final repo = WeatherRepository(api);
  final fav = FavoritesService();
  final settingsSvc = SettingsService();
  final settingsVM = SettingsViewModel(settingsSvc);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => settingsVM),
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(repo, fav, settingsVM),
        ),
        ChangeNotifierProvider(create: (_) => SearchViewModel(repo)),
        ChangeNotifierProvider(
          create: (_) => WeatherDetailViewModel(repo, settingsVM),
        ),
      ],
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather MVVM',
      theme: appTheme(context),
      onGenerateRoute: onGenerateRoute,
      initialRoute: Routes.home,
      debugShowCheckedModeBanner: false,
    );
  }
}
