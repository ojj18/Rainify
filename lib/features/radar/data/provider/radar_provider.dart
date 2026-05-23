import 'package:rainify/core/utils/network/app_helper.dart';

class RadarProvider {
  AppHelper appHelper = AppHelper();

  Future<String> getRadarTileUrl() async {
    try {
      final response = await appHelper.get(
        'https://api.rainviewer.com/public/weather-maps.json',
      );

      final radarData = response.data['radar'];

      final latestFrame = radarData['past'].last;

      final path = latestFrame['path'];

      return 'https://tilecache.rainviewer.com$path/512/{z}/{x}/{y}/2/1_1.png';
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
