// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/settings/bloc/settings_bloc.dart';
import 'package:superstore/pages/stock_map/components/east/bloc/east_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/one/bloc/north_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_zero_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/one/bloc/south_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/zero/bloc/south_zero_bloc.dart';
import 'package:superstore/pages/stock_map/components/west/bloc/west_bloc.dart';
import 'package:superstore/pages/utils/handle_search.dart';
import 'package:superstore/services/models/map_data.dart';

class SearchFunciton extends StatelessWidget {
  const SearchFunciton({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingSuccessState) {
          return IconButton(
            onPressed: () async {
              final val = await handleSearchMap(
                context,
                searchController,
                "Search Stock Map",
                // const TextInputType.numberWithOptions(),
              );

              if (val == null) return;

              final stateWest = BlocProvider.of<WestBloc>(context).state;
              final stateEast = BlocProvider.of<EastBloc>(context).state;
              final stateNorthZero =
                  BlocProvider.of<NorthZeroBloc>(context).state;
              final stateNorthOne =
                  BlocProvider.of<NorthOneBloc>(context).state;
              final stateSouthZero =
                  BlocProvider.of<SouthZeroBloc>(context).state;
              final stateSouthOne =
                  BlocProvider.of<SouthOneBloc>(context).state;
              if (stateWest is WestSuccessState &&
                  stateEast is EastSuccessState &&
                  stateNorthZero is NorthZeroSuccessState &&
                  stateNorthOne is NorthOneSuccessState &&
                  stateSouthZero is SouthZeroSuccessState &&
                  stateSouthOne is SouthOneSuccessState) {
                List<ZoneList> newWestZoneList = [];
                List<ZoneList> newEastZoneList = [];
                List<ZoneList> newNorthZeroZoneList = [];
                List<ZoneList> newNorthOneZoneList = [];
                List<ZoneList> newSouthZeroZoneList = [];
                List<ZoneList> newSouthOneZoneList = [];
                int foundWestCount = 0;
                int foundEastCount = 0;
                int foundNorthZeroCount = 0;
                int foundNorthOneCount = 0;
                int foundSouthZeroCount = 0;
                int foundSouthOneCount = 0;
                //west
                for (var zone in stateWest.mapData) {
                  if (zone.list!.any(
                    (map) =>
                        map.productId.toLowerCase().contains(
                              val.toLowerCase(),
                            ) ||
                        map.productName.toLowerCase().contains(
                              val.toLowerCase(),
                            ),
                  )) {
                    foundWestCount++;
                    newWestZoneList.add(
                      ZoneList.isThatCategory(zone),
                    );
                  } else {
                    newWestZoneList.add(zone);
                  }
                }

                //east
                for (var zone in stateEast.mapData) {
                  if (zone.list!.any(
                    (map) =>
                        map.productId.toLowerCase().contains(
                              val.toLowerCase(),
                            ) ||
                        map.productName.toLowerCase().contains(
                              val.toLowerCase(),
                            ),
                  )) {
                    foundEastCount++;
                    newEastZoneList.add(
                      ZoneList.isThatCategory(zone),
                    );
                  } else {
                    newEastZoneList.add(zone);
                  }
                }

                // //northZero
                // for (var zone in stateNorthZero.mapData) {
                //   if (zone.list!.any(
                //     (map) =>
                //         map.productId.toLowerCase().contains(
                //               val.toLowerCase(),
                //             ) ||
                //         map.productName.toLowerCase().contains(
                //               val.toLowerCase(),
                //             ),
                //   )) {
                //     foundNorthZeroCount++;
                //     newNorthZeroZoneList.add(
                //       ZoneList.isThatCategory(zone),
                //     );
                //   } else {
                //     newNorthZeroZoneList.add(zone);
                //   }
                // }

                // //northOne
                // for (var zone in stateNorthOne.mapData) {
                //   if (zone.list!.any(
                //     (map) =>
                //         map.productId.toLowerCase().contains(
                //               val.toLowerCase(),
                //             ) ||
                //         map.productName.toLowerCase().contains(
                //               val.toLowerCase(),
                //             ),
                //   )) {
                //     foundNorthOneCount++;
                //     newNorthOneZoneList.add(
                //       ZoneList.isThatCategory(zone),
                //     );
                //   } else {
                //     newNorthOneZoneList.add(zone);
                //   }
                // }

                //northZero
                for (var zone in stateNorthZero.mapData) {
                  if (zone.list!.any(
                    (map) =>
                        map.productId.toLowerCase().contains(
                              val.toLowerCase(),
                            ) ||
                        map.productName.toLowerCase().contains(
                              val.toLowerCase(),
                            ),
                  )) {
                    foundNorthZeroCount++;
                    newNorthZeroZoneList.add(
                      ZoneList.isThatCategory(zone),
                    );
                  } else {
                    newNorthZeroZoneList.add(zone);
                  }
                }

                //northOne
                for (var zone in stateNorthOne.mapData) {
                  if (zone.list!.any(
                    (map) =>
                        map.productId.toLowerCase().contains(
                              val.toLowerCase(),
                            ) ||
                        map.productName.toLowerCase().contains(
                              val.toLowerCase(),
                            ),
                  )) {
                    foundNorthOneCount++;
                    newNorthOneZoneList.add(
                      ZoneList.isThatCategory(zone),
                    );
                  } else {
                    newNorthOneZoneList.add(zone);
                  }
                }
                //southZero
                for (var zone in stateSouthZero.mapData) {
                  if (zone.list!.any(
                    (map) =>
                        map.productId.toLowerCase().contains(
                              val.toLowerCase(),
                            ) ||
                        map.productName.toLowerCase().contains(
                              val.toLowerCase(),
                            ),
                  )) {
                    foundSouthZeroCount++;
                    newSouthZeroZoneList.add(
                      ZoneList.isThatCategory(zone),
                    );
                  } else {
                    newSouthZeroZoneList.add(zone);
                  }
                }

                //southOne
                for (var zone in stateSouthOne.mapData) {
                  if (zone.list!.any(
                    (map) =>
                        map.productId.toLowerCase().contains(
                              val.toLowerCase(),
                            ) ||
                        map.productName.toLowerCase().contains(
                              val.toLowerCase(),
                            ),
                  )) {
                    foundSouthOneCount++;
                    newSouthOneZoneList.add(
                      ZoneList.isThatCategory(zone),
                    );
                  } else {
                    newSouthOneZoneList.add(zone);
                  }
                }

                if (foundWestCount > 0) {
                  context.read<WestBloc>().add(
                        WestUpdateIsCategoryEvent(
                          mapData: newWestZoneList,
                        ),
                      );
                }

                if (foundEastCount > 0) {
                  context.read<EastBloc>().add(
                        EastUpdateIsCategoryEvent(
                          mapData: newEastZoneList,
                        ),
                      );
                }

                if (foundNorthZeroCount > 0) {
                  context.read<NorthZeroBloc>().add(
                        NorthZeroUpdateIsCategoryEvent(
                          data: newNorthZeroZoneList,
                        ),
                      );
                }
                if (foundNorthOneCount > 0) {
                  context.read<NorthOneBloc>().add(
                        NorthOneUpdateIsCategoryEvent(
                          mapData: newNorthOneZoneList,
                        ),
                      );
                }
                if (foundSouthZeroCount > 0) {
                  context.read<SouthZeroBloc>().add(
                        SouthZeroUpdateIsCategoryEvent(
                          data: newSouthZeroZoneList,
                        ),
                      );
                }
                if (foundSouthOneCount > 0) {
                  context.read<SouthOneBloc>().add(
                        SouthOneUpdateIsCategoryEvent(
                          data: newSouthOneZoneList,
                        ),
                      );
                }
                // print((foundWestCount +
                //     foundEastCount +
                //     foundNorthZeroCount +
                //     foundNorthOneCount +
                //     foundSouthZeroCount +
                //     foundSouthOneCount));
                if ((foundWestCount +
                        foundEastCount +
                        foundNorthZeroCount +
                        foundNorthOneCount +
                        foundSouthZeroCount +
                        foundSouthOneCount) >
                    0) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 5),
                          content: Text(
                            "Look For Card That Color Changed To Teal",
                            style: TextStyle(
                              color: Colors.tealAccent,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((_) {
                    if (foundWestCount > 0) {
                      context.read<WestBloc>().add(
                            WestRefreshCategoryEvent(),
                          );
                    }
                    if (foundEastCount > 0) {
                      context.read<EastBloc>().add(
                            EastRefreshCategoryEvent(),
                          );
                    }
                    if (foundNorthZeroCount > 0) {
                      context.read<NorthZeroBloc>().add(
                            NorthZeroRefreshCategoryEvent(),
                          );
                    }
                    if (foundNorthOneCount > 0) {
                      context.read<NorthOneBloc>().add(
                            NorthOneRefreshCategoryEvent(),
                          );
                    }
                    if (foundSouthZeroCount > 0) {
                      context.read<SouthZeroBloc>().add(
                            SouthZeroRefreshCategoryEvent(),
                          );
                    }
                    if (foundSouthOneCount > 0) {
                      context.read<SouthOneBloc>().add(
                            SouthOneRefreshCategoryEvent(),
                          );
                    }
                  });
                }

                //         final combineLists = [
                //   ...stateWest.mapData.map((val) => val.list),
                //   ...stateEast.mapData.map((val) => val.list),
                //   ...stateNorthZero.mapData.map((val) => val.list),
                //   ...stateNorthOne.mapData.map((val) => val.list),
                //   ...stateSouthZero.mapData.map((val) => val.list),
                //   ...stateSouthOne.mapData.map((val) => val.list),
                // ].expand((map) => map!.map((single) => single)).toList();
                // final foundItems = combineLists
                //     .where(
                //       (map) =>
                //           map.productId.toLowerCase().contains(
                //                 val.toLowerCase(),
                //               ) ||
                //           map.productName.toLowerCase().contains(
                //                 val.toLowerCase(),
                //               ),
                //     )
                //     .toList();

                // if (foundItems.isNotEmpty) {
                //   final msg = "${foundItems.length} Messages Found!";
                //   final List<Text> msgs = foundItems
                //       .map(
                //         (msg) => Text(
                //           "${msg.productName} At: ${msg.sectionId.toUpperCase()} Zone:${msg.index}",
                //           style: const TextStyle(
                //             color: Colors.green,
                //             fontSize: 22,
                //           ),
                //         ),
                //       )
                //       .toList();
                //   handleScaffoldMessenger(
                //     context,
                //     Duration(
                //       seconds: state.setting.durationExtraLong,
                //     ),
                //     Column(
                //       children: [
                //         Text(
                //           msg,
                //           style: const TextStyle(
                //             color: Colors.green,
                //             fontSize: 22,
                //           ),
                //         ),
                //         ...msgs,
                //       ],
                //     ),
                //   );
                // } else {
                //   handleScaffoldMessenger(
                //     context,
                //     Duration(
                //       seconds: state.setting.durationShort,
                //     ),
                //     const Text(
                //       "Nothing Found!",
                //       style: TextStyle(
                //         color: Colors.red,
                //         fontSize: 16,
                //       ),
                //     ),
                //   );
                //   // ScaffoldMessenger.of(context).showSnackBar(
                //   //   const SnackBar(
                //   //     content: Text(
                //   //       "Nothing Found!",
                //   //       style: TextStyle(
                //   //         color: Colors.red,
                //   //         fontSize: 16,
                //   //       ),
                //   //     ),
                //   //   ),
                //   // );
                // }
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
