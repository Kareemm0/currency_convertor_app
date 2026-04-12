import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/core.dart';

class SharedPrefsLocalStorageImpl implements BaseLocalStorage {
  final SharedPreferences preferences;

  const SharedPrefsLocalStorageImpl({required this.preferences});

  @override
  Future<List<String>?> getStringList(String key) async {
    return preferences.getStringList(key);
  }

  @override
  Future<void> setStringList(String key, List<String> value) {
    return preferences.setStringList(key, value);
  }
}
