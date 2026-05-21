abstract class SettingState {}

class SettingsInitialState extends SettingState {}

class SettingsLoadingState extends SettingState {}

class SettingsSuccessState extends SettingState {}

class SettingsErrorState extends SettingState {
  String? errrorMessage;

  SettingsErrorState({required this.errrorMessage});
}
