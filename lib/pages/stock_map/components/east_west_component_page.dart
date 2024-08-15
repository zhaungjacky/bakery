// ignore_for_file: use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:superstore/pages/utils/handle_add_zone_map.dart';
import 'package:superstore/pages/utils/handle_browse_single_zone_items.dart';
import 'package:superstore/pages/utils/handle_bool.dart';
import 'package:superstore/pages/utils/handle_add_or_delete.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';
import 'package:superstore/services/singleton/singleton.dart';

class EastWestComponentPage extends StatefulWidget {
  const EastWestComponentPage({
    super.key,
    required this.data,
    required this.width,
    required this.fontSize,
  });

  final List<ZoneList> data;
  final double width;
  final double fontSize;

  @override
  State<EastWestComponentPage> createState() => _EastWestComponentPageState();
}

class _EastWestComponentPageState extends State<EastWestComponentPage> {
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
    // print(width);
    if (widget.data.isEmpty || widget.data[0].list == null) {
      return const Center(
        child: Text("No Stock"),
      );
    }
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          final map = widget.data[index].list![0];
          final String cardId = widget.data[index].id!;
          return SizedBox(
            width: widget.width / widget.data.length,
            height: MediaQuery.of(context).size.height * 0.1,
            child: GestureDetector(
              child: Card(
                color: widget.data[index].isCategory!
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
              //browse index card details
              onTap: () async {
                await handleBrowseSingleZoneItems(
                  context,
                  widget.data[index],
                  _productNameController,
                  _productIdController,
                  _sectionIdController,
                  _stockpileController,
                  _indexController,
                  "Zone: ${map.productName}'s Items",
                );
              },

              //delete
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
                    _indexController.text = map.index.toString();
                    await handleAddZoneMap(
                      context,
                      map.sectionId,
                      _productNameController,
                      _productIdController,
                      _sectionIdController,
                      _stockpileController,
                      _indexController,
                      widget.data.length,
                      widget.data,
                    );
                  } else {
                    final res = await handleBool(
                        context, "Delete Zone ${map.productName}?");
                    if (!res) return;
                    // print(map.sectionId);
                    // print(map.sectionId);
                    await singleton<MapDataRepo>().delZoneMapData(
                      map.sectionId,
                      cardId,
                    );
                  }
                } else {
                  return;
                }
              },

              // add map
              onDoubleTap: () async {
                try {
                  await handleAddZoneMap(
                    context,
                    map.sectionId,
                    _productNameController,
                    _productIdController,
                    _sectionIdController,
                    _stockpileController,
                    _indexController,
                    widget.data.length,
                    widget.data,
                  );
                  Navigator.of(context).pop();
                } on FirebaseException catch (_) {
                  return;
                }
              },
              /*
                    onTap: () async {
                _productNameController.text = map.productName;
                _productIdController.text = map.productId;
                _sectionIdController.text = map.sectionId;
                _stockpileController.text = map.stockpile.toString();
                _indexController.text = map.index.toString();

                final modifiedMap = await handleModifyMap(
                  context,
                  _productNameController,
                  _productIdController,
                  _sectionIdController,
                  _stockpileController,
                  _indexController,
                  map,
                  "Browse Or Modify?",
                );

                if (modifiedMap == null) return;

                final newMap = MapData(
                    index: modifiedMap["index"],
                    sectionId: modifiedMap["sectionId"],
                    productId: modifiedMap['productId'],
                    productName: modifiedMap["projectName"],
                    updatedAt: DateTime.now(),
                    createdAt: map.createdAt,
                    stockpile: modifiedMap['stockpile'],
                    id: map.id);
                // print(newMap);
                await singleton<MapDataRepo>().updateMapData(
                  map.id.toString(),
                  newMap,
                );
                // print(map.id);
                // print(map.sectionId);
              },


               */
            ),
          );
        });
  }
}
// class WestComponentPage extends StatelessWidget {
//   const WestComponentPage({
//     super.key,
//     required this.data,
//   });

//   final MapData data;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Text(data.productName),
//           const Gap(16),
//           Text(data.productId),
//           const Gap(16),
//           Text(data.stockpile.toString()),
//           const Gap(16),
//           IconButton(
//               color: Colors.green,
//               onPressed: () async {
//                 await singleton<MapDataRepo>().createMapData(
//                   "west",
//                   MapData(
//                     index: 0,
//                     uid: "uidasdasdsda",
//                     sectionId: "west_00",
//                     productId: "595",
//                     productName: "ACE Band",
//                     createdAt: DateTime.now(),
//                     stockpile: 25,
//                   ),
//                 );
//                 //   context.read<WestBloc>().add(
//                 //         WestAddEvent(
//                 //           data: MapData(
//                 //             index: 0,
//                 //             uid: "uidasdasdsda",
//                 //             sectionId: "west_00",
//                 //             productId: "595",
//                 //             productName: "ACE Band",
//                 //             createdAt: DateTime.now(),
//                 //             stockpile: 25,
//                 //           ),
//                 //         ),
//                 //       );
//                 //
//               },
//               icon: const Icon(Icons.add))
//         ],
//       ),
//     );
//   }
// }
