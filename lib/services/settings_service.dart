import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';

class SettingsService {
  static const _tKey = 'temp_unit';
  static const _sKey = 'speed_unit';

  Future<(TempUnit, SpeedUnit)> load() async {
    final p = await SharedPreferences.getInstance();
    final t = TempUnit.values[p.getInt(_tKey) ?? 0];
    final s = SpeedUnit.values[p.getInt(_sKey) ?? 0];
    return (t, s);
  }

  Future<void> save(TempUnit t, SpeedUnit s) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_tKey, t.index);
    await p.setInt(_sKey, s.index);
  }
}
