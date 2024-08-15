// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/settings/bloc/settings_bloc.dart';
import 'package:superstore/pages/utils/handle_add_tag.dart';
import 'package:superstore/pages/utils/handle_bool.dart';
import 'package:superstore/pages/utils/handle_scaffold_messenger.dart';
import 'package:superstore/services/serverice-model/service_repo.dart';
import 'package:superstore/services/singleton/singleton.dart';
import 'package:superstore/services/tags/model/tag_model.dart';

class TagCardTile extends StatelessWidget {
  const TagCardTile({
    super.key,
    required this.tag,
    required this.categoryController,
    required this.numbersOfProductController,
    required this.barCodeNumberController,
    required this.packageTypeController,
    required this.producedDayController,
    required this.durationController,
    required this.infoController,
  });

  final TagModel tag;
  final TextEditingController categoryController;
  final TextEditingController numbersOfProductController;
  final TextEditingController barCodeNumberController;
  final TextEditingController packageTypeController;
  final TextEditingController producedDayController;
  final TextEditingController durationController;
  final TextEditingController infoController;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // const tagWidthPercentList = [0.2, 0.6, 0.2];
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingSuccessState) {
          final tagWidthPercentList = state.setting.tagWidthPercentList;
          return Card(
            color: tag.isCategory! ? Colors.teal.shade100 : Colors.teal.shade50,
            child: ListTile(
              onTap: () async {
                categoryController.text = tag.category;
                numbersOfProductController.text =
                    tag.numbersOfProduct.toString();
                barCodeNumberController.text = tag.barCodeNumber.toString();
                packageTypeController.text = tag.packageType;
                producedDayController.text = tag.producedDay;
                durationController.text = tag.duration.toString();
                infoController.text = tag.info;
                var res = await handleAddTag(
                  context,
                  categoryController,
                  numbersOfProductController,
                  barCodeNumberController,
                  packageTypeController,
                  producedDayController,
                  durationController,
                  infoController,
                  "Modify Tag?",
                );
                if (res == null) {
                  categoryController.clear();
                  numbersOfProductController.clear();
                  barCodeNumberController.clear();
                  packageTypeController.clear();
                  producedDayController.clear();
                  durationController.clear();
                  infoController.clear();
                  return;
                }
                res["id"] = tag.id;
                final newTag = TagModel.fromMapData(res);
                // print(res);
                final updateStatus =
                    await singleton<ServiceRepo<TagModel>>().updateItem(newTag);
                if (updateStatus) {
                  handleScaffoldMessenger(
                    context,
                    const Duration(seconds: 2),
                    const Text(
                      "Update Success",
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  );
                } else {
                  handleScaffoldMessenger(
                    context,
                    const Duration(seconds: 1),
                    const Text(
                      "Update Failure",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  );
                }
              },
              onLongPress: () async {
                final res = await handleBool(
                  context,
                  "Confirm Deletion Of ${tag.category}",
                );
                if (!res) return;
                final delStatus =
                    await singleton<ServiceRepo<TagModel>>().delItem(
                  tag.id!,
                );
                if (delStatus) {
                  handleScaffoldMessenger(
                    context,
                    const Duration(seconds: 2),
                    const Text(
                      "Delete Success",
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  );
                } else {
                  handleScaffoldMessenger(
                    context,
                    const Duration(seconds: 1),
                    const Text(
                      "Delete Failure",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  );
                }
              },
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: Container(
                width: width * tagWidthPercentList[0],
                padding: const EdgeInsets.only(
                  right: 12,
                ),
                child: Text(
                  tag.barCodeNumber.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.amber.shade800,
                  ),
                ),
              ),
              title: SizedBox(
                width: width * tagWidthPercentList[1],
                child: Text(
                  tag.category,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
              subtitle: SizedBox(
                width: width * tagWidthPercentList[1],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Each package has: ${tag.numbersOfProduct}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.teal.shade800,
                      ),
                    ),
                    Text(tag.info),
                  ],
                ),
              ),
              trailing: SizedBox(
                width: width * tagWidthPercentList[2],
                child: Text(
                  "Product Duration: ${tag.duration}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red.shade600,
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
