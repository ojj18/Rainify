import 'package:rainify/features/settings/data/provider/settings_provider.dart';

class SettingsRepository {
  SettingsProvider settingsProvider;

  SettingsRepository({required this.settingsProvider});

  Future logoutMethod() {
    return settingsProvider.logoutMethod();
  }
}
