import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rainify/features/settings/bloc/bloc_event.dart';
import 'package:rainify/features/settings/bloc/bloc_state.dart';
import 'package:rainify/features/settings/data/repository/settings_repo.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingsRepository settingsRepository;

  SettingBloc(this.settingsRepository) : super((SettingsInitialState())) {
    on<SettingSuccessEvent>((event, emit) async {
      emit(SettingsLoadingState());

      try {
        await settingsRepository.logoutMethod();
        await Future.delayed(Duration(seconds: 3));
        emit(SettingsSuccessState());
      } catch (e) {
        emit(SettingsErrorState(errrorMessage: e.toString()));
      }
    });
  }
}
