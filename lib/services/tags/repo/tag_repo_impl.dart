import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superstore/services/serverice-model/service_data_source.dart';
import 'package:superstore/services/serverice-model/service_repo.dart';
import 'package:superstore/services/tags/model/tag_model.dart';

class TagRepoImpl implements ServiceRepo<TagModel> {
  final ServiceDateSource<TagModel> _servicedateSource;

  const TagRepoImpl({
    required ServiceDateSource<TagModel> servicedateSource,
  }) : _servicedateSource = servicedateSource;
  @override
  Future<bool> createItem(data) async {
    final res = await _servicedateSource.createItem(data);
    return res;
  }

  @override
  Future<bool> delItem(String id) async {
    final res = await _servicedateSource.delItem(id);
    return res;
  }

  @override
  Stream<QuerySnapshot<Object?>> getItems() {
    return _servicedateSource.getItems();
  }

  @override
  Future<bool> updateItem(data) async {
    return await _servicedateSource.updateItem(data);
  }

  @override
  String? get userId => _servicedateSource.userId;
}
