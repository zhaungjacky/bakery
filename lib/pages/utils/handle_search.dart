import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:superstore/pages/utils/my_material_button_widget.dart';

Future<String?> handleSearchMap(
    BuildContext context, TextEditingController searchController,
    [String? title, TextInputType? keyboardType]) {
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
        // content: const Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Gap(8),
        //   ],
        // ),
        actions: [
          Column(
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  label: Text(
                    "Search Content",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  hintText: "Content ...",
                ),
                keyboardType: keyboardType,
              ),
              const Gap(32),
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
                  MyMaterialButton(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: const Icon(
                      Icons.refresh,
                      size: 32,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    },
  );
}
