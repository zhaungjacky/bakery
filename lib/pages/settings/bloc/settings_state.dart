part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {
  const SettingsState();
}

final class SettingsInitial extends SettingsState {}

class SettingSuccessState extends SettingsState {
  final SettingModel setting;

  const SettingSuccessState({
    required this.setting,
  });
}

class SettingFailureOrErrorState extends SettingsState {
  final String? message;

  const SettingFailureOrErrorState({this.message});
}
