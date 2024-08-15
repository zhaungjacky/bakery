// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/tags/bloc/tags_bloc.dart';
import 'package:superstore/pages/utils/handle_scaffold_messenger.dart';
import 'package:superstore/pages/utils/handle_search.dart';
import 'package:superstore/services/tags/model/tag_model.dart';

class TagSearchAction extends StatelessWidget {
  const TagSearchAction({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagsBloc, TagsState>(
      builder: (context, state) {
        if (state is TagsSuccessState) {
          return IconButton(
            onPressed: () async {
              final val = await handleSearchMap(
                context,
                searchController,
                "Search Tag",
              );

              if (val == null) return;

              final newVal = val.toLowerCase();

              final foundList = state.list
                  .where((tag) =>
                          tag.category.toLowerCase().contains(newVal) ||
                          tag.info.toLowerCase().contains(newVal) ||
                          tag.packageType.toLowerCase().contains(newVal)
                      // ||
                      // tag.barCodeNumber == int.parse(val) ||
                      // tag.numbersOfProduct == int.parse(val) ||
                      // tag.duration == int.parse(val)
                      )
                  .toList();
              // print(foundList);
              if (foundList.isNotEmpty) {
                final newFoundList = foundList
                    .map((tag) => TagModel.foundCategory(tag))
                    .toList();

                context.read<TagsBloc>().add(
                      TagsUpdateFoundCategoryEvent(list: newFoundList),
                    );
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      const SnackBar(
                        duration: Duration(
                          seconds: 60,
                        ),
                        content: Text(
                          "Found Tags Above",
                          style: TextStyle(
                            color: Colors.tealAccent,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                    .closed
                    .then((_) {
                  context.read<TagsBloc>().add(
                        TagsRefreshEvent(),
                      );
                });
              } else {
                handleScaffoldMessenger(
                  context,
                  const Duration(seconds: 2),
                  const Text(
                    "No Tags Found",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.search,
              color: Colors.blue,
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
