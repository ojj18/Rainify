import '../model/forcast_main_model.dart';
import '../provider/dashboard_provider.dart';

abstract class IforcastRepository {
  Future<ForcastModel> getForCastData({required String city});
}

class DashboardRepository implements IforcastRepository {
  final DashboardProvider dashboardProvider;

  const DashboardRepository({required this.dashboardProvider});

  @override
  Future<ForcastModel> getForCastData({required String city}) {
    return dashboardProvider.getForcastResult(city);
  }
}
