// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:superstore/pages/utils/handle_modify_bool.dart';
import 'package:superstore/pages/utils/handle_modify_map.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';
import 'package:superstore/services/singleton/singleton.dart';

class NorthSouthComponentPage extends StatefulWidget {
  const NorthSouthComponentPage({
    super.key,
    required this.items,
  });

  final List<MapData> items;

  @override
  State<NorthSouthComponentPage> createState() =>
      _NorthSouthComponentPageState();
}

class _NorthSouthComponentPageState extends State<NorthSouthComponentPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _sectionIdController = TextEditingController();
  final TextEditingController _stockpileController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _productIdController.dispose();
    _sectionIdController.dispose();
    _stockpileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final map = widget.items[index];
          return SizedBox(
            height:
                MediaQuery.of(context).size.height * 0.6 / widget.items.length,
            child: GestureDetector(
              child: Card(
                child: Center(child: Text(map.productName)),
              ),
              onTap: () async {
                // final res = await handleBool(context);

                // if (!res) return;

                _productNameController.text = map.productName;
                _productIdController.text = map.productId;
                _sectionIdController.text = map.sectionId;
                _stockpileController.text = map.stockpile.toString();

                final modifiedMap = await handleModifyMap(
                    context,
                    _productNameController,
                    _productIdController,
                    _sectionIdController,
                    _stockpileController,
                    map,
                    "Browse Or Modify?");

                if (modifiedMap == null) return;

                var newMap = MapData(
                  index: map.index,
                  uid: map.uid,
                  sectionId: modifiedMap["sectionId"],
                  productId: modifiedMap['productId'],
                  productName: modifiedMap["projectName"],
                  createdAt: DateTime.now(),
                  stockpile: int.parse(modifiedMap['stockpile']),
                );
                // print(newMap);
                await singleton<MapDataRepo>().updateMapData(map.id!, newMap);
              },
              onLongPress: () async {
                final res =
                    await handleBool(context, "Delete Map ${map.productName}?");
                if (!res) return;
                await singleton<MapDataRepo>().delMapData(
                  map.sectionId,
                  map.id!,
                );
              },
            ),
          );
        });
  }
}
