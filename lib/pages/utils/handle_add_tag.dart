import 'package:flutter/material.dart';
import 'package:superstore/pages/utils/my_material_button_widget.dart';
// import 'package:superstore/services/tags/model/tag_model.dart';

/*
    required this.category,
    required this.numbersOfProduct,
    required this.barCodeNumber,
    required this.packageType,
    required this.producedDay,
    required this.duration,
    required this.info,
    required this.isLegal,
 */
Future<Map<String, dynamic>?> handleAddTag(
// Future<TagModel?> handleAddTag(
    BuildContext context,
    TextEditingController categoryController,
    TextEditingController numbersOfProductController,
    TextEditingController barCodeNumberController,
    TextEditingController packageTypeController,
    TextEditingController producedDayController,
    TextEditingController durationController,
    TextEditingController infoController,
    // TextEditingController isLegalController,
    [String? title]) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(title ?? "Add Tag?"),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //category
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Category",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                //numbers of product
                TextField(
                  controller: numbersOfProductController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Number Of Product",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(),
                ),

                //barCodeNumberController
                TextField(
                  controller: barCodeNumberController,
                  decoration: const InputDecoration(
                    label: Text(
                      "BarCode  ",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(),
                ),

                //packageTypeController
                TextField(
                  controller: packageTypeController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Package Type",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                //producedDayController
                TextField(
                  controller: producedDayController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Day Of Prodution",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(),
                ),

                //durationController
                TextField(
                  controller: durationController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Duration Days",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(),
                ),

                //infoController
                TextField(
                  controller: infoController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Info Or Bio",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // //isLegalController
                // TextField(
                //   controller: isLegalController,
                //   decoration: const InputDecoration(
                //     label: Text(
                //       "Legal Category?",
                //       style: TextStyle(
                //         color: Colors.green,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyMaterialButton(
                  onPressed: () {
                    // final tag = TagModel(
                    //   category: categoryController.text,
                    //   numbersOfProduct:
                    //       int.parse(numbersOfProductController.text),
                    //   barCodeNumber: int.parse(barCodeNumberController.text),
                    //   packageType: packageTypeController.text,
                    //   producedDay: producedDayController.text,
                    //   duration: int.parse(durationController.text),
                    //   info: infoController.text,
                    //   isLegal: bool.parse(isLegalController.text),
                    // );
                    if (categoryController.text.isEmpty ||
                        numbersOfProductController.text.isEmpty ||
                        barCodeNumberController.text.isEmpty ||
                        packageTypeController.text.isEmpty ||
                        producedDayController.text.isEmpty ||
                        durationController.text.isEmpty ||
                        infoController.text.isEmpty) {
                      Navigator.of(context).pop(null);
                      return;
                    }

                    final tag = {
                      'category': categoryController.text,
                      'numbersOfProduct':
                          int.parse(numbersOfProductController.text),
                      'barCodeNumber': int.parse(barCodeNumberController.text),
                      'packageType': packageTypeController.text,
                      'producedDay': producedDayController.text,
                      'duration': int.parse(durationController.text),
                      'info': infoController.text,
                      'isLegal': true,
                      'expiredDate': (DateTime.parse(
                        producedDayController.text,
                      ))
                          .add(
                            Duration(
                              days: int.parse(durationController.text),
                            ),
                          )
                          .toIso8601String(),
                    };
                    Navigator.of(context).pop(tag);
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
      });
}
