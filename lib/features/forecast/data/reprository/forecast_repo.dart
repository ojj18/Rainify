import '../model/forecast_main_model.dart';
import '../provider/forecast_provider.dart';

abstract class IforecastRepository {
  Future<ForcastModel> getForCastData({required String city});
}

class ForecastRepository implements IforecastRepository {
  final ForecastProvider forcastProvider;

  const ForecastRepository({required this.forcastProvider});

  @override
  Future<ForcastModel> getForCastData({required String city}) {
    return forcastProvider.getForcastResult(city);
  }
}
