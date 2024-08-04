import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superstore/services/map/data-source/map_data_source.dart';
import 'package:superstore/services/models/map_data.dart';

abstract interface class MapDataRepo {
  Stream<QuerySnapshot<Object?>> getMapData(String zone);
  Future<void> updateMapData(String id, MapData data);
  Future<void> createMapData(String zone, MapData data);
  Future<void> delMapData(String sectionId, String id);
}

class MapDataRepoImpl implements MapDataRepo {
  final MapDataSource _mapDataSource;

  MapDataRepoImpl({required MapDataSource mapDataSource})
      : _mapDataSource = mapDataSource;

  @override
  Future<void> createMapData(String zone, MapData data) async {
    await _mapDataSource.createMapData(zone, data);
  }

  @override
  Future<void> delMapData(String sectionId, String id) async {
    await _mapDataSource.delMapData(sectionId, id);
  }

  @override
  Stream<QuerySnapshot<Object?>> getMapData(String zone) {
    final res = _mapDataSource.getMapData(zone);
    return res;
  }

  @override
  Future<void> updateMapData(String id, MapData data) async {
    await _mapDataSource.updateMapData(id, data);
  }
}
