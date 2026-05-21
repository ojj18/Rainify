import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rainify/features/login/bloc/bloc_event.dart';
import 'package:rainify/features/login/bloc/bloc_state.dart';
import 'package:rainify/features/login/data/repository/login_repo.dart';

import '../../../core/utils/location_service.dart';
import '../../../core/utils/storage_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository;

  LoginBloc(this.loginRepository) : super(LoginInitialState()) {
    on<LoginSuccessEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        await loginRepository.loginMethod(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccessState());
      } catch (e) {
        emit(LoginErrorState(errorMessage: e.toString()));
      }
    });

    on<GoogleSignUpEvent>((event, emit) async {
      final locationService = LocationService();
      final storageService = StorageService();
      emit(LoginLoadingState());
      try {
        final isPreciseLocation =
            await storageService.getPreciseLocation() ?? false;
        final position = await locationService.getCurrentPosition(
          isPerciseLocation: isPreciseLocation,
        );

        await loginRepository.googleSignUpMethod(
          latitude: position.latitude,
          longitude: position.longitude,
        );
        emit(LoginSuccessState());
      } catch (e) {
        emit(LoginErrorState(errorMessage: e.toString()));
      }
    });
    on<AppleSignUpEvent>((event, emit) async {
      final locationService = LocationService();
      final storageService = StorageService();
      emit(LoginLoadingState());
      try {
        final isPreciseLocation =
            await storageService.getPreciseLocation() ?? false;
        final position = await locationService.getCurrentPosition(
          isPerciseLocation: isPreciseLocation,
        );

        await loginRepository.appleSignUpMethod(
          latitude: position.latitude,
          longitude: position.longitude,
        );
        emit(LoginSuccessState());
      } catch (e) {
        emit(LoginErrorState(errorMessage: e.toString()));
      }
    });
  }
}
