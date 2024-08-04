// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/stock_map/components/east/bloc/east_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/one/bloc/north_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/one/bloc/south_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/zero/bloc/south_zero_bloc.dart';
import 'package:superstore/pages/stock_map/components/west/bloc/west_bloc.dart';
import 'package:superstore/pages/utils/handle_search.dart';

class SearchFunciton extends StatelessWidget {
  const SearchFunciton({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final val = await handleSearchMap(
          context,
          searchController,
        );

        if (val == null) return;

        final stateWest = BlocProvider.of<WestBloc>(context).state;
        final stateEast = BlocProvider.of<EastBloc>(context).state;
        final stateNorthZero = BlocProvider.of<NorthZeroBloc>(context).state;
        final stateNorthOne = BlocProvider.of<NorthOneBloc>(context).state;
        final stateSouthZero = BlocProvider.of<SouthZeroBloc>(context).state;
        final stateSouthOne = BlocProvider.of<SouthOneBloc>(context).state;
        if (stateWest is WestSuccessState &&
            stateEast is EastSuccessState &&
            stateNorthZero is NorthZeroSuccessState &&
            stateNorthOne is NorthOneSuccessState &&
            stateSouthZero is SouthZeroSuccessState &&
            stateSouthOne is SouthOneSuccessState) {
          final combineLists = [
            stateWest.mapData,
            stateEast.mapData,
            stateNorthZero.mapData,
            stateNorthOne.mapData,
            stateSouthZero.mapData,
            stateSouthOne.mapData,
          ].expand((map) => map).toList();
          // print(combineLists.length);
          final foundIndex = combineLists.indexWhere(
            (map) =>
                map.productId.toLowerCase().contains(
                      val.toLowerCase(),
                    ) ||
                map.productName.toLowerCase().contains(
                      val.toLowerCase(),
                    ),
          );
          if (foundIndex > -1) {
            final msg =
                "${combineLists[foundIndex].productName} located at: ${combineLists[foundIndex].sectionId} and index: ${combineLists[foundIndex].index}";

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  msg,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 22,
                  ),
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Nothing Found!",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }
        }

        // if (state is WestSuccessState) {
        //   if (state.mapData.any(
        //     (map) =>
        //         map.productId.toLowerCase().contains(
        //               val.toLowerCase(),
        //             ) ||
        //         map.productName.toLowerCase().contains(
        //               val.toLowerCase(),
        //             ),
        //   )) {
        //     final foundIndex = state.mapData.indexWhere(
        //       (map) =>
        //           map.productId.toLowerCase().contains(
        //                 val.toLowerCase(),
        //               ) ||
        //           map.productName.toLowerCase().contains(
        //                 val.toLowerCase(),
        //               ),
        //     );

        //     final msg =
        //         "${state.mapData[foundIndex].sectionId} and index: ${state.mapData[foundIndex].index}";

        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Text(msg),
        //       ),
        //     );
        //   } else {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(
        //         content: Text("Nothing Found!"),
        //       ),
        //     );
        //   }
        // }
      },
      icon: const Icon(
        Icons.search,
        color: Colors.blue,
      ),
    );
  }
}
