// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:superstore/pages/utils/handle_add_zone_map.dart';
import 'package:superstore/pages/utils/handle_browse_single_zone_items.dart';
import 'package:superstore/pages/utils/handle_bool.dart';
import 'package:superstore/pages/utils/handle_add_or_delete.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';
import 'package:superstore/services/singleton/singleton.dart';

class NorthSouthComponentPage extends StatefulWidget {
  const NorthSouthComponentPage({
    super.key,
    required this.items,
    required this.height,
    required this.fontSize,
  });

  final List<ZoneList> items;
  final double height;
  final double fontSize;

  @override
  State<NorthSouthComponentPage> createState() =>
      _NorthSouthComponentPageState();
}

class _NorthSouthComponentPageState extends State<NorthSouthComponentPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _sectionIdController = TextEditingController();
  final TextEditingController _stockpileController = TextEditingController();
  final TextEditingController _indexController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _productIdController.dispose();
    _sectionIdController.dispose();
    _stockpileController.dispose();
    _indexController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty || widget.items[0].list == null) {
      return const Center(
        child: Text("No Stock"),
      );
    }
    return ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final map = widget.items[index].list![0];
          final String cardId = widget.items[index].id!;
          return SizedBox(
            height: widget.height / widget.items.length,
            // height:
            //     MediaQuery.of(context).size.height * 0.6 / widget.items.length,
            child: GestureDetector(
              child: Card(
                color: widget.items[index].isCategory!
                    ? Colors.tealAccent
                    : Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      map.productName,
                      style: TextStyle(
                        fontSize: widget.fontSize,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () async {
                await handleBrowseSingleZoneItems(
                  context,
                  widget.items[index],
                  _productNameController,
                  _productIdController,
                  _sectionIdController,
                  _stockpileController,
                  _indexController,
                  "Zone: ${map.productName}'s Items",
                );
                // _productNameController.text = map.productName;
                // _productIdController.text = map.productId;
                // _sectionIdController.text = map.sectionId;
                // _stockpileController.text = map.stockpile.toString();
                // _indexController.text = map.index.toString();

                // final modifiedMap = await handleModifyMap(
                //   context,
                //   _productNameController,
                //   _productIdController,
                //   _sectionIdController,
                //   _stockpileController,
                //   _indexController,
                //   map,
                //   "Browse Or Modify?",
                // );

                // if (modifiedMap == null) return;

                // var newMap = MapData(
                //     index: modifiedMap['index'],
                //     sectionId: modifiedMap["sectionId"],
                //     productId: modifiedMap['productId'],
                //     productName: modifiedMap["projectName"],
                //     updatedAt: DateTime.now(),
                //     stockpile: modifiedMap['stockpile'],
                //     createdAt: map.createdAt,
                //     id: map.id);
                // print(newMap);
                // await singleton<MapDataRepo>().updateMapData(
                //   map.id.toString(),
                //   newMap,
                // );
              },
              onLongPress: () async {
                _productNameController.clear();
                _productIdController.clear();
                _sectionIdController.clear();
                _stockpileController.clear();
                _indexController.clear();
                final bool? addOrDeleteOrCancel =
                    await handleAddOrDelete(context);
                if (addOrDeleteOrCancel != null) {
                  if (addOrDeleteOrCancel) {
                    //add map
                    _indexController.text = map.index.toString();
                    await handleAddZoneMap(
                      context,
                      map.sectionId,
                      _productNameController,
                      _productIdController,
                      _sectionIdController,
                      _stockpileController,
                      _indexController,
                      widget.items.length,
                      widget.items,
                    );
                  } else {
                    //delete map
                    final res = await handleBool(
                        context, "Delete Zone ${map.productName}?");
                    if (!res) return;
                    await singleton<MapDataRepo>().delZoneMapData(
                      map.sectionId,
                      cardId,
                    );
                  }
                } else {
                  return;
                }
              },
            ),
          );
        });
  }
}
