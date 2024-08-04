import 'package:flutter/material.dart';
import 'package:superstore/pages/utils/my_material_button_widget.dart';
import 'package:superstore/services/models/map_data.dart';

Future<dynamic> handleModifyMap(
    BuildContext context,
    TextEditingController productNameController,
    TextEditingController productIdController,
    TextEditingController sectionIdController,
    TextEditingController stockpileController,
    MapData data,
    [String? title]) {
  return showDialog(
    context: context,
    builder: (content) {
      return AlertDialog(
        title: Text(
          title ?? "Modify Map Data ?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          TextField(
            controller: productNameController,
            decoration: const InputDecoration(
              helperText: "Product Name",
              helperStyle: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextField(
            controller: productIdController,
            decoration: const InputDecoration(
              helperText: "Product ID",
              helperStyle: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextField(
            controller: sectionIdController,
            decoration: const InputDecoration(
              helperText: "Section ID",
              helperStyle: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextField(
            controller: stockpileController,
            decoration: const InputDecoration(
              helperText: "Stockpile",
              helperStyle: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyMaterialButton(
                onPressed: () {
                  final val = {
                    "projectName": productNameController.text,
                    "productId": productIdController.text,
                    "sectionId": sectionIdController.text,
                    "stockpile": stockpileController.text,
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
