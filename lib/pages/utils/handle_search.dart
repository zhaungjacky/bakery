import 'package:flutter/material.dart';
import 'package:superstore/pages/utils/my_material_button_widget.dart';

Future<String?> handleSearchMap(
    BuildContext context, TextEditingController searchController,
    [String? title]) {
  return showDialog(
    context: context,
    builder: (content) {
      return AlertDialog(
        title: Text(
          title ?? "Input Search Value",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
                helperText: "Search Content",
                helperStyle: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
                hintText: "search content ..."),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyMaterialButton(
                onPressed: () {
                  final val = searchController.text;
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
