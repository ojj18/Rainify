import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/location_service.dart';
import '../../../core/utils/storage_service.dart';
import '../data/reprository/forecast_repo.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastRepository forcastRepository;
  ForecastBloc(this.forcastRepository) : super(ForecastInitalState()) {
    on<ForecastDataLoaded>((event, emit) async {
      final locationService = LocationService();
      final storageService = StorageService();
      emit(ForecastLoadingState());

      try {
        final isPreciseLocation =
            await storageService.getPreciseLocation() ?? false;
        final position = await locationService.getCurrentPosition(
          isPerciseLocation: isPreciseLocation,
        );
        debugPrint(position.latitude.toString());

        debugPrint(position.longitude.toString());

        var latlong = '${position.latitude},${position.longitude}';

        final forcast = await forcastRepository.getForCastData(city: latlong);

        emit(ForecastSuccessState(forcast));
      } catch (e) {
        emit(ForecastErrorState(errorMessage: e.toString()));
      }
    });
  }
}
