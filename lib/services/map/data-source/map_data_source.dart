import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:superstore/services/models/map_data.dart';

abstract interface class MapDataSource {
  Stream<QuerySnapshot<Object?>> getMapData(String zone);
  Future<void> updateMapData(String id, MapData data);
  Future<void> createMapData(String zone, MapData data);
  Future<void> delMapData(
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
  Future<void> createMapData(String zone, MapData data) async {
    try {
      await _firestore
          .collection(mainCollection())
          .doc(userId)
          .collection(zone)
          .add(
            data.toJson(),
          );
    } on FirebaseException catch (err) {
      throw Exception(err.message);
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getMapData(String zone) {
    try {
      return _firestore
          .collection(mainCollection())
          .doc(userId)
          .collection(zone)
          .orderBy(
            "index",
          )
          .snapshots() as Stream<QuerySnapshot<Object?>>;
    } on FirebaseException catch (err) {
      throw Exception(err.message);
    }
  }

  @override
  Future<void> updateMapData(
    String id,
    MapData data,
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
  Future<void> delMapData(String sectionId, String id) async {
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
