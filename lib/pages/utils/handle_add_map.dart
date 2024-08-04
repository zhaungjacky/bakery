import 'package:flutter/material.dart';
import 'package:superstore/pages/utils/my_material_button_widget.dart';

Future<dynamic> handleAddMap(
    BuildContext context,
    String secitonId,
    TextEditingController productNameController,
    TextEditingController productIdController,
    TextEditingController sectionIdController,
    TextEditingController stockpileController,
    [String? title]) {
  return showDialog(
    context: context,
    builder: (content) {
      sectionIdController.text = secitonId;
      return AlertDialog(
        title: Text(
          title ?? "Add Map Data?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          TextField(
            controller: sectionIdController,
            decoration: const InputDecoration(
              helperText: "Section ID",
              helperStyle: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            readOnly: true,
          ),
          TextField(
            controller: productNameController,
            decoration: const InputDecoration(
                helperText: "Product Name",
                helperStyle: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
                hintText: "name ..."),
          ),
          TextField(
            controller: productIdController,
            decoration: const InputDecoration(
                helperText: "Product ID",
                helperStyle: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
                hintText: "product id ..."),
          ),
          TextField(
            controller: stockpileController,
            decoration: const InputDecoration(
                helperText: "Stockpile",
                helperStyle: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
                hintText: "stockpile ..."),
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
