import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superstore/services/setting/data-source/setting_data_source.dart';
import 'package:superstore/services/setting/model/setting_model.dart';

abstract interface class SettingDataRepo {
  Stream<QuerySnapshot<Object?>> getItems();
  Future<bool> createItem(SettingModel data);
  String? get uid;
}

class SettingDataRepoImpl implements SettingDataRepo {
  final SettingDataSource _settingDataSorce;

  SettingDataRepoImpl({
    required SettingDataSource settingDataSorce,
  }) : _settingDataSorce = settingDataSorce;

  @override
  Future<bool> createItem(SettingModel data) async {
    return await _settingDataSorce.createItem(data);
  }

  @override
  Stream<QuerySnapshot<Object?>> getItems() {
    return _settingDataSorce.getItems();
  }

  @override
  String? get uid => _settingDataSorce.uid;
}
