import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superstore/services/setting/model/setting_model.dart';
import 'package:superstore/services/setting/repo/setting_data_repo.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  late final StreamSubscription _streamSubscription;
  final SettingDataRepo _settingDataRepo;
  SettingsBloc({required SettingDataRepo settingDataRepo})
      : _settingDataRepo = settingDataRepo,
        super(SettingsInitial()) {
    _streamSubscription = _settingDataRepo.getItems().listen((event) {
      final settingData = event.docs.map((doc) {
        // print(doc);
        return SettingModel.fromJson(doc);
      }).toList();
      if (settingData.isNotEmpty) {
        // print(settingData[0]);
        add(
          SettingLoadEvent(
            setting: settingData[0],
          ),
        );
      } else {
        final settingData = SettingModel(
          fontSize: 15,
          heightsPercentList: [0.1, 0.635, 0.1],
          widthPercentList: [0.225, 0.05, 0.225, 0.225, 0.05, 0.225],
          tagWidthPercentList: [0.2, 0.6, 0.2],
          durationShort: 1,
          durationMedium: 3,
          durationLong: 8,
          durationExtraLong: 15,
          showDrawerAddSettingZone: false,
        );
        _settingDataRepo.createItem(
          settingData,
        );
      }
      // final settingData = event.docs.map((doc) {
      //   print("Start iterator");
      //   print(doc["fontSize"]);
      //   return SettingModel.fromJson(doc);
      // }).toList();
      // print("setting data is: $settingData");
      // add(
      //   SettingLoadEvent(
      //     setting: settingData[0],
      //   ),
      // );
    });
    on<SettingsEvent>(
      (_, emit) => emit(
        SettingsInitial(),
      ),
    );
    on<SettingLoadEvent>(_load);
  }

  _load(SettingLoadEvent event, Emitter emit) {
    emit(
      SettingSuccessState(setting: event.setting),
    );
  }

  @override
  Future<void> close() async {
    super.close();

    await _streamSubscription.cancel();
  }
}
