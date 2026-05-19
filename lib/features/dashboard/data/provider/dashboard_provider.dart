import '../../../../core/utils/network/app_endpoint.dart';
import '../../../../core/utils/network/app_helper.dart';
import '../model/forcast_main_model.dart';

class DashboardProvider {
  AppHelper appHelper = AppHelper();

  Future<ForcastModel> getForcastResult(String city) async {
    final respons = await appHelper.get(
      AppEndpoint.forcastWeatherUrl,
      queryParameters: {"q": city.toString(), "days": 7},
    );
    return ForcastModel.fromJson(respons.data);
  }
}
