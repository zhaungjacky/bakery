// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/tags/bloc/tags_bloc.dart';
import 'package:superstore/pages/tags/components/tag_drawer.dart';
import 'package:superstore/pages/tags/components/tag_list_view.dart';
import 'package:superstore/pages/tags/components/tag_search_action.dart';
import 'package:superstore/pages/utils/handle_add_tag.dart';
import 'package:superstore/pages/utils/handle_scaffold_messenger.dart';
import 'package:superstore/services/serverice-model/service_repo.dart';
import 'package:superstore/services/singleton/singleton.dart';
import 'package:superstore/services/tags/model/tag_model.dart';

class TagsPage extends StatefulWidget {
  const TagsPage({super.key});
  static String routhPath() => "/tags";

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController numbersOfProductController = TextEditingController();
  TextEditingController barCodeNumberController = TextEditingController();
  TextEditingController packageTypeController = TextEditingController();
  TextEditingController producedDayController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  // TextEditingController isLegalController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    categoryController.dispose();
    numbersOfProductController.dispose();
    barCodeNumberController.dispose();
    packageTypeController.dispose();
    producedDayController.dispose();
    durationController.dispose();
    infoController.dispose();
    searchController.dispose();
    // isLegalController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tags"),
        centerTitle: true,
        elevation: 1,
        actions: [
          TagSearchAction(
            searchController: searchController,
          ),
        ],
      ),
      drawer: const SafeArea(
        child: TagDrawer(),
      ),
      body: BlocBuilder<TagsBloc, TagsState>(
        builder: (context, state) {
          switch (state) {
            case TagsInitial():
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case TagsSuccessState():
              final list = state.list
                  .where(
                    (tag) => tag.isLegal,
                  )
                  .toList();
              // print(list);
              return TagListView(
                list: list,
                categoryController: categoryController,
                numbersOfProductController: numbersOfProductController,
                barCodeNumberController: barCodeNumberController,
                packageTypeController: packageTypeController,
                producedDayController: producedDayController,
                durationController: durationController,
                infoController: infoController,
              );
            case TagsFailureOrErrorState():
              return Center(
                child: Text(
                  state.message,
                ),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          producedDayController.text = DateTime.now().toIso8601String();
          durationController.text = "4";
          infoController.text = "...";
          final res = await handleAddTag(
            context,
            categoryController,
            numbersOfProductController,
            barCodeNumberController,
            packageTypeController,
            producedDayController,
            durationController,
            infoController,
            // isLegalController,
          );
          // print(res);
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
          // final tag = TagModel.fromMapData(res);
          // print(tag.numbersOfProduct);
          final addRes = await singleton<ServiceRepo<TagModel>>()
              .createItem(TagModel.fromMapData(res));
          if (addRes) {
            handleScaffoldMessenger(
              context,
              const Duration(seconds: 2),
              const Text(
                "Add Tag Success",
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
                "Add Tag Failure",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          }
          categoryController.clear();
          numbersOfProductController.clear();
          barCodeNumberController.clear();
          packageTypeController.clear();
          producedDayController.clear();
          durationController.clear();
          infoController.clear();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
