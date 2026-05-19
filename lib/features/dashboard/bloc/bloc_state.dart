import 'package:rainify/features/dashboard/data/model/forcast_main_model.dart';

abstract class DashboardState {}

final class DashboardInitalState extends DashboardState {}

final class DashboardLoadingState extends DashboardState {}

final class DashboardSuccessState extends DashboardState {
  ForcastModel forcastModel;

  DashboardSuccessState(this.forcastModel);
}

final class DashboardErrorState extends DashboardState {
  String? errorMessage;

  DashboardErrorState({this.errorMessage});
}
