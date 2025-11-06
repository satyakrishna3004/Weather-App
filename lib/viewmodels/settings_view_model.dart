import 'package:flutter/foundation.dart';
import '../core/constants.dart';
import '../services/settings_service.dart';

class SettingsViewModel extends ChangeNotifier {
  final SettingsService _svc;
  SettingsViewModel(this._svc);

  TempUnit temp = TempUnit.celsius;
  SpeedUnit speed = SpeedUnit.kph;

  bool get isMetric => temp == TempUnit.celsius;
  String get unitsQuery => isMetric ? 'metric' : 'imperial';

  Future<void> load() async {
    final x = await _svc.load();
    temp = x.$1;
    speed = x.$2;
    notifyListeners();
  }

  Future<void> setUnits(TempUnit t, SpeedUnit s) async {
    temp = t;
    speed = s;
    notifyListeners();
    await _svc.save(t, s);
  }

  String formatTemp(double v) =>
      isMetric ? '${v.toStringAsFixed(0)}°C' : '${v.toStringAsFixed(0)}°F';
  String formatSpeed(double ms) {
    if (speed == SpeedUnit.kph) return '${(ms * 3.6).toStringAsFixed(0)} km/h';
    return '${(ms * 2.23694).toStringAsFixed(0)} mph';
  }
}
