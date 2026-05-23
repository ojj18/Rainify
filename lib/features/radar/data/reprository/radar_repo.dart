import 'package:rainify/features/radar/data/provider/radar_provider.dart';

abstract class IRadarReprository {
  Future<String> getRadarTileUrl();
}

class RadarRepository extends IRadarReprository {
  RadarProvider radarProvider;

  RadarRepository({required this.radarProvider});

  @override
  Future<String> getRadarTileUrl() {
    return radarProvider.getRadarTileUrl();
  }
}
