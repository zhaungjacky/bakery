import 'package:flutter/material.dart';
import 'package:superstore/pages/utils/my_material_button_widget.dart';

// const List<int> indexList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];
Future<dynamic> handleAddMap(
    BuildContext context,
    String secitonId,
    TextEditingController productNameController,
    TextEditingController productIdController,
    TextEditingController sectionIdController,
    TextEditingController stockpileController,
    TextEditingController indexController,
    int len,
    [String? title]) {
  var newLen = 0;
  if (len == 0) {
    newLen = 1;
  } else {
    newLen = len + 1;
  }
  final List<int> indexList = List.generate(newLen, (i) => i);
  stockpileController.text = "1";

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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownMenu<int>(
              width: 240,
              // initi
              controller: indexController,

              label: const Text(
                "Choose index",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              initialSelection: indexController.text.isEmpty
                  ? indexList[indexList.length - 1]
                  : int.parse(indexController.text),
              dropdownMenuEntries: indexList
                  .map(
                    (ele) => DropdownMenuEntry(
                      value: ele,
                      label: ele.toString(),
                    ),
                  )
                  .toList(),
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
              readOnly: true,
            ),
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
                  hintText: "name ..."),
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
                  hintText: "product id ..."),
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
                  hintText: "stockpile ..."),
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
                    "stockpile": stockpileController.text,
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
