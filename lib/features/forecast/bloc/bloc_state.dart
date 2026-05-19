import '../data/model/forecast_main_model.dart';

abstract class ForecastState {}

final class ForecastInitalState extends ForecastState {}

final class ForecastLoadingState extends ForecastState {}

final class ForecastSuccessState extends ForecastState {
  ForcastModel forcastModel;

  ForecastSuccessState(this.forcastModel);
}

final class ForecastErrorState extends ForecastState {
  String? errorMessage;

  ForecastErrorState({this.errorMessage});
}
