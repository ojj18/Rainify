abstract class RadarState {}

class RadarInitialState extends RadarState {}

class RadarLoadingState extends RadarState {}

class RadarSuccessState extends RadarState {
  final String radarUrl;
  RadarSuccessState({required this.radarUrl});
}

class RadarErrorState extends RadarState {
  final String errorMessage;
  RadarErrorState({required this.errorMessage});
}
