import 'package:chat_system/app/shered/repositories/shared_preferences_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository implements ISharedPreferencesRepositoryInterface {
  @override
  Future save({required String key, required List<String> item}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, item);
  }

  @override
  Future deleteInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("Credentials");
  }

  @override
  Future getInfo({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }
}
