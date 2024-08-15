// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:superstore/pages/utils/handle_bool.dart';
import 'package:superstore/pages/utils/handle_modify_map.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';
import 'package:superstore/services/singleton/singleton.dart';

class MapCardComponent extends StatelessWidget {
  const MapCardComponent({
    super.key,
    required this.item,
    required this.zoneList,
    required this.productNameController,
    required this.productIdController,
    required this.sectionIdController,
    required this.stockpileController,
    required this.indexController,
  });

  final MapData item;
  final ZoneList zoneList;
  final TextEditingController productNameController;
  final TextEditingController productIdController;
  final TextEditingController sectionIdController;
  final TextEditingController stockpileController;
  final TextEditingController indexController;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            item.productName,
            style: TextStyle(
              fontSize: 18,
              color: Colors.orange.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //modify
        onTap: () async {
          Navigator.of(context).pop();
          productNameController.text = item.productName;
          productIdController.text = item.productId;
          sectionIdController.text = item.sectionId;
          stockpileController.text = item.stockpile.toString();
          indexController.text = item.index.toString();
          final modifiedMap = await handleModifyMap(
            context,
            productNameController,
            productIdController,
            sectionIdController,
            stockpileController,
            indexController,
            item,
          );

          if (modifiedMap == null) return;

          final newMap = MapData(
            index: modifiedMap["index"],
            sectionId: modifiedMap["sectionId"],
            productId: modifiedMap['productId'],
            productName: modifiedMap["projectName"],
            updatedAt: DateTime.now(),
            createdAt: item.createdAt,
            stockpile: modifiedMap['stockpile'],
            id: item.id,
          );

          final foundIndex =
              zoneList.list!.indexWhere((val) => val.id == item.id);
          var newList = zoneList.list!;
          newList.removeAt(foundIndex);
          newList.insert(foundIndex, newMap);
          final newZoneList = ZoneList(
            sectionId: zoneList.sectionId,
            index: newMap.index,
            list: newList,
            createdAt: zoneList.createdAt,
            updatedAt: DateTime.now(),
          );
          // Navigator.of(context).pop();
          await singleton<MapDataRepo>().updateMapData(
            zoneList.id!,
            newZoneList,
          );
        },
        //delete
        onLongPress: () async {
          if (zoneList.list?.length == 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Column(
                  children: [
                    Text(
                      "Only One Map, Modify Only!",
                      style: TextStyle(color: Colors.red),
                    ),
                    Gap(16),
                    Text(
                      "You Can Delete Zone From Main Screen!",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            );
            return;
          }
          final confirmDel =
              await handleBool(context, "Delete Map ${item.productName}?");
          if (!confirmDel) return;
          final foundIndex =
              zoneList.list!.indexWhere((val) => val.id == item.id);
          var newList = zoneList.list!;
          newList.removeAt(foundIndex);
          final newZoneList = ZoneList(
            sectionId: zoneList.sectionId,
            index: zoneList.index,
            list: newList,
            createdAt: zoneList.createdAt,
            updatedAt: DateTime.now(),
          );
          Navigator.of(context).pop();
          await singleton<MapDataRepo>().updateMapData(
            zoneList.id!,
            newZoneList,
          );
        },
      ),
    );
  }
}
