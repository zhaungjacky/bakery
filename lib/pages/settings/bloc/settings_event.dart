part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {
  const SettingsEvent();
}

class SettingLoadEvent extends SettingsEvent {
  final SettingModel setting;

  const SettingLoadEvent({required this.setting});
}
