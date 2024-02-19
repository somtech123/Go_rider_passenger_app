import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  saveInAppTutor() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('@tour', true);
  }

  Future<bool> getSaveInAppTutor() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('@tour')) {
      bool? data = prefs.getBool('@tour');
      return data!;
    } else {
      return false;
    }
  }
}
