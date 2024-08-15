import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:superstore/services/serverice-model/service_data_source.dart';
import 'package:superstore/services/tags/model/tag_model.dart';

class TagDataSourceImpl implements ServiceDateSource<TagModel> {
  static String mainCollection() => "tags";
  static String secondaryCollection() => "tag";
  static String doc() => "bakery";

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  String? get userId => _firebaseAuth.currentUser?.uid;
  @override
  Future<bool> createItem(TagModel data) async {
    try {
      final res = await _firebaseFirestore
          .collection(
            mainCollection(),
          )
          .doc(
            doc(),
          )
          .collection(
            secondaryCollection(),
          )
          .add(
            data.toJson(),
          );
      if (res.id.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (_) {
      return false;
    }
  }

  @override
  Future<bool> delItem(String id) async {
    try {
      await _firebaseFirestore
          .collection(
            mainCollection(),
          )
          .doc(
            doc(),
          )
          .collection(
            secondaryCollection(),
          )
          .doc(id)
          .delete();
      return true;
    } on FirebaseException catch (_) {
      return false;
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getItems() {
    try {
      final res = _firebaseFirestore
          .collection(
            mainCollection(),
          )
          .doc(
            doc(),
          )
          .collection(
            secondaryCollection(),
          )
          // .equalTo()

          .orderBy("category")
          .snapshots();
      return res;
    } on FirebaseException catch (err) {
      throw Exception(err.message);
    }
  }

  @override
  Future<bool> updateItem(TagModel data) async {
    try {
      await _firebaseFirestore
          .collection(
            mainCollection(),
          )
          .doc(
            doc(),
          )
          .collection(
            secondaryCollection(),
          )
          .doc(data.id)
          .set(
            data.toJson(),
          );
      return true;
    } on FirebaseException catch (_) {
      return false;
    }
  }
}
