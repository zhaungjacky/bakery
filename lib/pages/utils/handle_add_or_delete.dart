import 'package:flutter/material.dart';
import 'package:superstore/pages/utils/my_material_button_widget.dart';

Future<dynamic> handleAddOrDelete(BuildContext context, [String? title]) {
  return showDialog(
    context: context,
    builder: (content) {
      return AlertDialog(
        title: Text(
          title ?? "Add Or Delete Map?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyMaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                icon: const Icon(
                  Icons.add,
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
                  color: Colors.blue,
                ),
              ),
              MyMaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                icon: const Icon(
                  Icons.delete,
                  size: 32,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      );
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(
      //   const SnackBar(
      //       content: Text("Delete item!")),
      // );
    },
  );
}
