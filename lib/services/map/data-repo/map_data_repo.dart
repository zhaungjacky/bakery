import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superstore/services/map/data-source/map_data_source.dart';
import 'package:superstore/services/models/map_data.dart';

abstract interface class MapDataRepo {
  Stream<QuerySnapshot<Object?>> getMapData(String sectionId);
  Future<void> updateMapData(String id, ZoneList data);
  Future<void> createMapData(MapData data, [ZoneList? zoneList]);
  Future<void> delZoneMapData(String sectionId, String id);
}

class MapDataRepoImpl implements MapDataRepo {
  final MapDataSource _mapDataSource;

  MapDataRepoImpl({required MapDataSource mapDataSource})
      : _mapDataSource = mapDataSource;

  @override
  Future<void> createMapData(MapData data, [ZoneList? zoneList]) async {
    await _mapDataSource.createMapData(data, zoneList);
  }

  @override
  Future<void> delZoneMapData(String sectionId, String id) async {
    await _mapDataSource.delZoneMapData(sectionId, id);
  }

  @override
  Stream<QuerySnapshot<Object?>> getMapData(String sectionId) {
    final res = _mapDataSource.getMapData(sectionId);
    return res;
  }

  @override
  Future<void> updateMapData(String id, ZoneList data) async {
    await _mapDataSource.updateMapData(id, data);
  }
}
