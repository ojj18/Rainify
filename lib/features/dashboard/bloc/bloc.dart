import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rainify/core/utils/location_service.dart';
import 'package:rainify/core/utils/storage_service.dart';

import '../data/reprository/dashboard_repo.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class DashboardBloc extends Bloc<ForcastEvent, DashboardState> {
  DashboardRepository forcastRepository;
  DashboardBloc(this.forcastRepository) : super(DashboardInitalState()) {
    on<ForcastDataLoaded>((event, emit) async {
      final locationService = LocationService();
      final storageService = StorageService();
      emit(DashboardLoadingState());

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

        emit(DashboardSuccessState(forcast));
      } catch (e) {
        emit(DashboardErrorState(errorMessage: e.toString()));
      }
    });
  }
}
