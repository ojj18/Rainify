import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<void> setPreciseLocation(bool isPerciseLocation) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.setBool("precise_location", isPerciseLocation);
  }

  Future<bool?> getPreciseLocation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final preciseLocation = sharedPreferences.getBool("precise_location");
    return preciseLocation;
  }
}
