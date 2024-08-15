// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:superstore/pages/auth/bloc/auth_bloc.dart';
import 'package:superstore/pages/settings/bloc/settings_bloc.dart';
import 'package:superstore/pages/stock_map/components/east/bloc/east_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/one/bloc/north_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_zero_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/one/bloc/south_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/zero/bloc/south_zero_bloc.dart';
import 'package:superstore/pages/stock_map/components/west/bloc/west_bloc.dart';
import 'package:superstore/pages/tags/components/tag_drawer.dart';
import 'package:superstore/pages/utils/handle_add_zone_map.dart';
import 'package:superstore/services/singleton/singleton.dart';
import 'package:superstore/services/setting/model/setting_model.dart';
import 'package:superstore/services/setting/repo/setting_data_repo.dart';
import 'package:superstore/pages/utils/handle_scaffold_messenger.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productIdController = TextEditingController();
  final TextEditingController sectionIdController = TextEditingController();
  final TextEditingController stockpileController = TextEditingController();
  final TextEditingController indexController = TextEditingController();

  final double gapData = 1;

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    productIdController.dispose();
    sectionIdController.dispose();
    stockpileController.dispose();
    indexController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final westLen = BlocProvider.of<WestBloc>(context, listen: false).state;
    final eastLen = BlocProvider.of<EastBloc>(context, listen: false).state;
    final northZeroLen =
        BlocProvider.of<NorthZeroBloc>(context, listen: false).state;
    final northOneLen =
        BlocProvider.of<NorthOneBloc>(context, listen: false).state;
    final southZeroLen =
        BlocProvider.of<SouthZeroBloc>(context, listen: false).state;
    final southOneLen =
        BlocProvider.of<SouthOneBloc>(context, listen: false).state;
    final authState = BlocProvider.of<AuthBloc>(context, listen: false).state;
    final settingsState = BlocProvider.of<SettingsBloc>(context).state;

    if (settingsState is SettingSuccessState) {
      return Drawer(
        child: Column(
          children: [
            if (authState is AuthSuccessState)
              DrawerHeader(
                child: Column(
                  children: [
                    const Gap(16),
                    const Text(
                      "Backery",
                      style: TextStyle(fontSize: 36),
                    ),
                    Text(
                      authState.user.email!,
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            Gap(gapData),
            //add west zone map data
            ListTile(
              leading: const Icon(
                Icons.north,
                color: Colors.red,
              ),
              title: const Text(("Add West Map")),
              onTap: () async {
                if (westLen is WestSuccessState) {
                  await handleAddZoneMap(
                    context,
                    SectionZones.west.name,
                    productNameController,
                    productIdController,
                    sectionIdController,
                    stockpileController,
                    indexController,
                    westLen.mapData.length,
                    westLen.mapData,
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
            Gap(gapData),
            //add East zone map data
            ListTile(
              leading: const Icon(
                Icons.south,
                color: Colors.green,
              ),
              title: const Text("Add East Map"),
              onTap: () async {
                if (eastLen is EastSuccessState) {
                  await handleAddZoneMap(
                    context,
                    SectionZones.east.name,
                    productNameController,
                    productIdController,
                    sectionIdController,
                    stockpileController,
                    indexController,
                    eastLen.mapData.length,
                    eastLen.mapData,
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
            Gap(gapData),
            //add NorthZero Map
            ListTile(
              leading: Icon(
                Icons.north_east,
                color: Colors.yellow[800],
              ),
              title: const Text("Add NorthZero Map"),
              onTap: () async {
                if (northZeroLen is NorthZeroSuccessState) {
                  await handleAddZoneMap(
                    context,
                    SectionZones.northZero.name,
                    productNameController,
                    productIdController,
                    sectionIdController,
                    stockpileController,
                    indexController,
                    northZeroLen.mapData.length,
                    northZeroLen.mapData,
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
            Gap(gapData),
            //add NorthOne Map
            ListTile(
                leading: const Icon(
                  Icons.south_east,
                  color: Colors.blue,
                ),
                title: const Text("Add NorthOne Map"),
                onTap: () async {
                  if (northOneLen is NorthOneSuccessState) {
                    await handleAddZoneMap(
                      context,
                      SectionZones.northOne.name,
                      productNameController,
                      productIdController,
                      sectionIdController,
                      stockpileController,
                      indexController,
                      northOneLen.mapData.length,
                      northOneLen.mapData,
                    );
                    Navigator.of(context).pop();
                  }
                }),
            Gap(gapData),
            //add SouthZero map
            ListTile(
                leading: const Icon(
                  Icons.north_west,
                  color: Colors.red,
                ),
                title: const Text("Add SouthZero Map"),
                onTap: () async {
                  if (southZeroLen is SouthZeroSuccessState) {
                    await handleAddZoneMap(
                      context,
                      SectionZones.southZero.name,
                      productNameController,
                      productIdController,
                      sectionIdController,
                      stockpileController,
                      indexController,
                      southZeroLen.mapData.length,
                      southZeroLen.mapData,
                    );
                    Navigator.of(context).pop();
                  }
                }),
            Gap(gapData),
            //add SouthOne map
            ListTile(
                leading: const Icon(
                  Icons.south_west,
                  color: Colors.black,
                ),
                title: const Text("Add SouthOne Map"),
                onTap: () async {
                  if (southOneLen is SouthOneSuccessState) {
                    await handleAddZoneMap(
                      context,
                      SectionZones.southOne.name,
                      productNameController,
                      productIdController,
                      sectionIdController,
                      stockpileController,
                      indexController,
                      southOneLen.mapData.length,
                      southOneLen.mapData,
                    );
                    Navigator.of(context).pop();
                  }
                }), //add NorthOne map
            Gap(gapData),
            const Divider(),

            //navi to tags page
            const GoToTagsTile(), //add NorthOne map
            Gap(gapData),

            //navi to speech to text page
            const GoToSpeechToTextTile(), //add NorthOne map
            Gap(gapData),

            if (settingsState.setting.showDrawerAddSettingZone)
              //add setting data
              const AddUserSettingDataTile(),

            Gap(gapData),
            const Spacer(),
            const Divider(),

            const LogoutTile()
            // ListTile(
            //   leading: const Icon(
            //     Icons.logout,
            //     color: Colors.red,
            //   ),
            //   title: const Text("Logout"),
            //   onTap: () async {
            //     await singleton<AuthRepository>().logout();
            //   },
            // ),
            // const Gap(24),
          ],
        ),
      );
    } else {
      return const Drawer();
    }
  }
}

class AddUserSettingDataTile extends StatelessWidget {
  const AddUserSettingDataTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.settings,
        color: Colors.green,
      ),
      title: const Text("Add My Setting Data"),
      onTap: () async {
        final settingData = SettingModel(
          fontSize: 15,
          heightsPercentList: [0.1, 0.635, 0.1],
          widthPercentList: [0.225, 0.05, 0.225, 0.225, 0.05, 0.225],
          tagWidthPercentList: [0.2, 0.6, 0.2],
          durationShort: 1,
          durationMedium: 3,
          durationLong: 8,
          durationExtraLong: 15,
          showDrawerAddSettingZone: false,
        );
        final res = await singleton<SettingDataRepo>().createItem(settingData);
        if (res) {
          handleScaffoldMessenger(
            context,
            Durations.medium1,
            const Text(
              "Add Setting Data Success",
            ),
          );
        } else {
          handleScaffoldMessenger(
            context,
            Durations.short1,
            const Text(
              "Add Setting Data Failure",
            ),
          );
        }
      },
    );
  }
}


/*

    BlocBuilder<SouthOneBloc, SouthOneState>(
            builder: (context, state) {
              final currentZone = SectionZones.southOne.toString();
              return ListTile(
                leading: const Icon(Icons.add),
                title: const Text("Add SouthOne Map"),
                onTap: () async {
                  final inputData = await handleAddMap(
                    context,
                    currentZone,
                    productNameController,
                    productIdController,
                    sectionIdController,
                    stockpileController,
                    indexController,
                  );

                  if (productNameController.text.isEmpty ||
                      productIdController.text.isEmpty ||
                      sectionIdController.text.isEmpty ||
                      stockpileController.text.isEmpty) return;
                  if (inputData == null) return;
                  if (state is SouthOneSuccessState) {
                    final newIndex =
                        state.mapData[(state.mapData.length) - 1].index + 1;
                    final newMap = MapData(
                      index: newIndex,
                      uid: "random number",
                      sectionId: inputData["sectionId"],
                      productId: inputData['productId'],
                      productName: inputData["projectName"],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      stockpile: int.parse(inputData['stockpile']),
                    );

                    await singleton<MapDataRepo>().createMapData(
                      currentZone,
                      newMap,
                    );
                  }
                  // await singleton<AuthRepository>().logout();
                },
              );
            },
          ),
          
          
 */
