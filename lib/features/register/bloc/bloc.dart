import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rainify/features/register/bloc/bloc_event.dart';
import 'package:rainify/features/register/bloc/bloc_state.dart';
import 'package:rainify/features/register/data/repository/register_repo.dart';

import '../../../core/utils/location_service.dart';
import '../../../core/utils/storage_service.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterRepository registerRepository;

  RegisterBloc(this.registerRepository) : super(RegisterInitalState()) {
    on<RegisterSuccessEvent>((event, emit) async {
      final locationService = LocationService();
      final storageService = StorageService();
      emit(RegisterLoadingState());
      try {
        final isPreciseLocation =
            await storageService.getPreciseLocation() ?? false;
        final position = await locationService.getCurrentPosition(
          isPerciseLocation: isPreciseLocation,
        );

        debugPrint(position.latitude.toString());

        debugPrint(position.longitude.toString());
        await registerRepository.registerUser(
          email: event.email,
          fullName: event.fullName,
          password: event.password,
          latitude: position.latitude,
          longitude: position.longitude,
        );
        emit(RegisterSuccessState());
      } catch (e) {
        emit(RegisterErrorState(errorMessage: e.toString()));
      }
    });
  }
}
