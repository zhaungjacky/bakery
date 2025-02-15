import 'package:flutter/material.dart';
import 'package:superstore/pages/utils/my_material_button_widget.dart';
import 'package:superstore/services/models/map_data.dart';

Future<dynamic> handleModifyMap(
    BuildContext context,
    TextEditingController productNameController,
    TextEditingController productIdController,
    TextEditingController sectionIdController,
    TextEditingController stockpileController,
    TextEditingController indexController,
    MapData data,
    [String? title]) {
  // print(data.productName);
  return showDialog(
    context: context,
    builder: (content) {
      return AlertDialog(
        title: Text(
          title ?? "Modify Map Data?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: productNameController,
              decoration: const InputDecoration(
                label: Text(
                  "Product Name",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextField(
              controller: productIdController,
              decoration: const InputDecoration(
                label: Text(
                  "Product ID",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextField(
              controller: indexController,
              decoration: const InputDecoration(
                label: Text(
                  "Index",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextField(
              controller: sectionIdController,
              decoration: const InputDecoration(
                label: Text(
                  "Section ID",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextField(
              controller: stockpileController,
              decoration: const InputDecoration(
                label: Text(
                  "Stockpile",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyMaterialButton(
                onPressed: () {
                  final val = {
                    "projectName": productNameController.text,
                    "productId": productIdController.text,
                    "sectionId": sectionIdController.text,
                    "stockpile": int.parse(stockpileController.text),
                    "index": int.parse(indexController.text),
                  };
                  Navigator.of(context).pop(val);
                },
                icon: const Icon(
                  Icons.done,
                  size: 32,
                  color: Colors.green,
                ),
              ),
              MyMaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
                icon: const Icon(
                  Icons.cancel,
                  size: 32,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
