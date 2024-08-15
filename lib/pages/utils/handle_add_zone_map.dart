import 'package:flutter/material.dart';
import 'package:superstore/pages/utils/generate_random_string.dart';
import 'package:superstore/pages/utils/handle_add_map.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';
import 'package:superstore/services/singleton/singleton.dart';

Future<void> handleAddZoneMap(
    BuildContext context,
    String section,
    TextEditingController productNameController,
    TextEditingController productIdController,
    TextEditingController sectionIdController,
    TextEditingController stockpileController,
    TextEditingController indexController,
    int len,
    [List<ZoneList>? list]) async {
  final inputData = await handleAddMap(
    context,
    section,
    productNameController,
    productIdController,
    sectionIdController,
    stockpileController,
    indexController,
    len,
  );
  if (productNameController.text.isEmpty ||
      productIdController.text.isEmpty ||
      sectionIdController.text.isEmpty ||
      stockpileController.text.isEmpty ||
      indexController.text.isEmpty) return;
  if (inputData == null) return;

  // print("inputData is: $inputData");

  final map = MapData(
    id: generateRandomString(16),
    sectionId: inputData["sectionId"],
    index: inputData["index"],
    productId: inputData['productId'],
    productName: inputData["projectName"],
    stockpile: int.parse(inputData['stockpile']),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  if (list != null) {
    final findZoneList = list
        .where(
          (val) => val.index == int.parse(indexController.text),
        )
        .toList();
    if (findZoneList.isNotEmpty) {
      // print(findZoneList[0]);
      await singleton<MapDataRepo>().createMapData(map, findZoneList[0]);
    } else {
      await singleton<MapDataRepo>().createMapData(map);
    }
  } else {
    await singleton<MapDataRepo>().createMapData(map);
  }

  productNameController.clear();
  productIdController.clear();
  sectionIdController.clear();
  stockpileController.clear();
  indexController.clear();

  // final newMapList = oldList.list == null ? [map] : [...(oldList.list!), map];
  // ZoneList zoneList = ZoneList(
  //   sectionId: inputData["sectionId"],
  //   index: inputData["index"],
  //   list: newMapList,
  //   createdAt: DateTime.now(),
  //   updatedAt: DateTime.now(),
  // );
}
