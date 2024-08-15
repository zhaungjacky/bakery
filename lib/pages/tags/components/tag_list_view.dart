// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:superstore/pages/tags/components/tag_card_tile.dart';
import 'package:superstore/pages/utils/handle_bool.dart';
import 'package:superstore/services/serverice-model/service_repo.dart';
import 'package:superstore/services/singleton/singleton.dart';
import 'package:superstore/services/tags/model/tag_model.dart';

class TagListView extends StatelessWidget {
  const TagListView({
    super.key,
    required this.list,
    required this.categoryController,
    required this.numbersOfProductController,
    required this.barCodeNumberController,
    required this.packageTypeController,
    required this.producedDayController,
    required this.durationController,
    required this.infoController,
  });

  final List<TagModel> list;
  final TextEditingController categoryController;
  final TextEditingController numbersOfProductController;
  final TextEditingController barCodeNumberController;
  final TextEditingController packageTypeController;
  final TextEditingController producedDayController;
  final TextEditingController durationController;
  final TextEditingController infoController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final tag = list[index];
          return Container(
            margin: const EdgeInsets.only(left: 6, right: 6, top: 6),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Dismissible(
              key: Key(tag.id!),
              direction: DismissDirection.endToStart,
              confirmDismiss: (_) async {
                final res = await handleBool(
                  context,
                  'Make This Tag Inactivate?',
                );
                if (!res) return;
                final makeTagInactivate = TagModel.makeTagInactivate(tag);
                await singleton<ServiceRepo<TagModel>>()
                    .updateItem(makeTagInactivate);
                return null;
              },
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.red.shade300,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TagCardTile(
                    tag: tag,
                    categoryController: categoryController,
                    numbersOfProductController: numbersOfProductController,
                    barCodeNumberController: barCodeNumberController,
                    packageTypeController: packageTypeController,
                    producedDayController: producedDayController,
                    durationController: durationController,
                    infoController: infoController),
              ),
            ),
          );
        });
  }
}
