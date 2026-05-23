import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rainify/features/radar/bloc/bloc_event.dart';
import 'package:rainify/features/radar/bloc/bloc_state.dart';
import 'package:rainify/features/radar/data/reprository/radar_repo.dart';

class RadarBloc extends Bloc<RadarEvent, RadarState> {
  RadarRepository radarRepository;

  RadarBloc(this.radarRepository) : super(RadarInitialState()) {
    on<RadarDataLoadedEvent>((event, emit) async {
      emit(RadarLoadingState());
      try {
        final response = await radarRepository.getRadarTileUrl();
        emit(RadarSuccessState(radarUrl: response));
      } catch (e) {
        emit(RadarErrorState(errorMessage: e.toString()));
      }
    });
  }
}
