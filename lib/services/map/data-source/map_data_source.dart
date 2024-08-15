import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:superstore/services/models/map_data.dart';

abstract interface class MapDataSource {
  Stream<QuerySnapshot<Object?>> getMapData(String sectionId);
  Future<void> updateMapData(String id, ZoneList data);
  Future<void> createMapData(MapData data, [ZoneList? zoneList]);
  Future<void> delZoneMapData(
    String sectionId,
    String id,
  );

  //

  String? get userId;
}

class MapDataSourceImpl implements MapDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  String? get userId => _auth.currentUser?.uid;

  static String mainCollection() => "maps";
  // static String secondaryCollection() => "maps";

  @override
  Stream<QuerySnapshot<Object?>> getMapData(String sectionId) {
    try {
      return _firestore
          .collection(mainCollection())
          .doc(userId)
          .collection(sectionId)
          .orderBy(
            "index",
          )
          // .orderBy("createdAt")
          // .orderBy("updatedAt")
          .snapshots() as Stream<QuerySnapshot<Object?>>;
    } on FirebaseException catch (err) {
      throw Exception(err.message);
    }
  }

  @override
  Future<void> createMapData(MapData data, [ZoneList? zoneList]) async {
    try {
      if (zoneList == null) {
        final jewZoneList = ZoneList(
          sectionId: data.sectionId,
          index: data.index,
          list: [data],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await _firestore
            .collection(mainCollection())
            .doc(userId)
            .collection(data.sectionId)
            .add(
              jewZoneList.toJson(),
            );
      } else {
        final newZoneList = ZoneList(
          sectionId: zoneList.sectionId,
          index: zoneList.index,
          list: [...zoneList.list!, data],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _firestore
            .collection(mainCollection())
            .doc(userId)
            .collection(data.sectionId)
            .doc(zoneList.id)
            .set(
              newZoneList.toJson(),
            );
      }
    } on FirebaseException catch (err) {
      // print(err.message);
      throw Exception(err.message);
    }
  }

  @override
  Future<void> updateMapData(
    String id,
    ZoneList data,
  ) async {
    try {
      await _firestore
          .collection(mainCollection())
          .doc(userId)
          .collection(data.sectionId)
          .doc(id)
          .set(
            data.toJson(),
          );
    } on FirebaseException catch (err) {
      throw Exception(err.message);
    }
  }

  @override
  Future<void> delZoneMapData(String sectionId, String id) async {
    try {
      await _firestore
          .collection(mainCollection())
          .doc(userId)
          .collection(sectionId)
          .doc(id)
          .delete();
    } on FirebaseException catch (err) {
      throw Exception(err.message);
    }
  }
}
