import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:superstore/services/setting/model/setting_model.dart';

abstract interface class SettingDataSource {
  Stream<QuerySnapshot<Object?>> getItems();
  Future<bool> createItem(SettingModel data);
  String? get uid;
}

class SettingDataSourceImpl implements SettingDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static String mainCollection() => "settings";
  static String secondaryCollection() => "setting";
  // static String? docId() => _firebaseAuth.currentUser?.uid;
  @override
  Future<bool> createItem(SettingModel data) async {
    try {
      await _firebaseFirestore
          .collection(mainCollection())
          .doc(uid)
          .collection(secondaryCollection())
          .add(data.toJson());
      return true;
    } on FirebaseException catch (_) {
      return false;
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getItems() {
    final res = _firebaseFirestore
        .collection(mainCollection())
        .doc(uid)
        .collection(secondaryCollection())
        .orderBy("fontSize")
        .snapshots();
    // print(res);
    return res;
  }

  @override
  String? get uid => _firebaseAuth.currentUser?.uid;
}
