import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/stock_map/components/east/bloc/east_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/one/bloc/north_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/one/bloc/south_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/zero/bloc/south_zero_bloc.dart';
import 'package:superstore/pages/stock_map/components/west/bloc/west_bloc.dart';
import 'package:superstore/pages/utils/handle_add_map.dart';
import 'package:superstore/services/auth/repo/auth_repo.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';
import 'package:superstore/services/singleton/singleton.dart';

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

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    productIdController.dispose();
    sectionIdController.dispose();
    stockpileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Text(
              "Backery",
              style: TextStyle(fontSize: 40),
            ),
          ),

          //add west zone map data
          BlocBuilder<WestBloc, WestState>(
            builder: (context, state) {
              final currentZone = SectionZones.west.toString();
              return ListTile(
                leading: const Icon(Icons.add),
                title: const Text("Add West Map"),
                onTap: () async {
                  final inputData = await handleAddMap(
                    context,
                    currentZone,
                    productNameController,
                    productIdController,
                    sectionIdController,
                    stockpileController,
                  );
                  if (productNameController.text.isEmpty ||
                      productIdController.text.isEmpty ||
                      sectionIdController.text.isEmpty ||
                      stockpileController.text.isEmpty) return;
                  if (inputData == null) return;
                  if (state is WestSuccessState) {
                    final newIndex =
                        state.mapData[(state.mapData.length) - 1].index + 1;
                    final newMap = MapData(
                      index: newIndex,
                      uid: "random number",
                      sectionId: inputData["sectionId"],
                      productId: inputData['productId'],
                      productName: inputData["projectName"],
                      createdAt: DateTime.now(),
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

          //add East zone map data
          BlocBuilder<EastBloc, EastState>(
            builder: (context, state) {
              final currentZone = SectionZones.east.toString();
              return ListTile(
                leading: const Icon(Icons.add),
                title: const Text("Add East Map"),
                onTap: () async {
                  final inputData = await handleAddMap(
                    context,
                    currentZone,
                    productNameController,
                    productIdController,
                    sectionIdController,
                    stockpileController,
                  );

                  if (productNameController.text.isEmpty ||
                      productIdController.text.isEmpty ||
                      sectionIdController.text.isEmpty ||
                      stockpileController.text.isEmpty) return;
                  if (inputData == null) return;
                  if (state is EastSuccessState) {
                    final newIndex =
                        state.mapData[(state.mapData.length) - 1].index + 1;
                    final newMap = MapData(
                      index: newIndex,
                      uid: "random number",
                      sectionId: inputData["sectionId"],
                      productId: inputData['productId'],
                      productName: inputData["projectName"],
                      createdAt: DateTime.now(),
                      stockpile: int.parse(inputData['stockpile']),
                    );

                    await singleton<MapDataRepo>().createMapData(
                      currentZone,
                      newMap,
                    );
                  }
                },
              );
            },
          ),

          //add NorthZero Map
          BlocBuilder<NorthZeroBloc, NorthZeroState>(
            builder: (context, state) {
              final currentZone = SectionZones.northZero.toString();
              return ListTile(
                leading: const Icon(Icons.add),
                title: const Text("Add NorthZero Map"),
                onTap: () async {
                  final inputData = await handleAddMap(
                    context,
                    currentZone,
                    productNameController,
                    productIdController,
                    sectionIdController,
                    stockpileController,
                  );

                  if (productNameController.text.isEmpty ||
                      productIdController.text.isEmpty ||
                      sectionIdController.text.isEmpty ||
                      stockpileController.text.isEmpty) return;
                  if (inputData == null) return;
                  if (state is NorthZeroSuccessState) {
                    final newIndex =
                        state.mapData[(state.mapData.length) - 1].index + 1;
                    final newMap = MapData(
                      index: newIndex,
                      uid: "random number",
                      sectionId: inputData["sectionId"],
                      productId: inputData['productId'],
                      productName: inputData["projectName"],
                      createdAt: DateTime.now(),
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

          //add NorthOne map

          BlocBuilder<NorthOneBloc, NorthOneState>(
            builder: (context, state) {
              final currentZone = SectionZones.northOne.toString();
              return ListTile(
                leading: const Icon(Icons.add),
                title: const Text("Add NorthOne Map"),
                onTap: () async {
                  final inputData = await handleAddMap(
                    context,
                    currentZone,
                    productNameController,
                    productIdController,
                    sectionIdController,
                    stockpileController,
                  );

                  if (productNameController.text.isEmpty ||
                      productIdController.text.isEmpty ||
                      sectionIdController.text.isEmpty ||
                      stockpileController.text.isEmpty) return;
                  if (inputData == null) return;
                  if (state is NorthOneSuccessState) {
                    final newIndex =
                        state.mapData[(state.mapData.length) - 1].index + 1;
                    final newMap = MapData(
                      index: newIndex,
                      uid: "random number",
                      sectionId: inputData["sectionId"],
                      productId: inputData['productId'],
                      productName: inputData["projectName"],
                      createdAt: DateTime.now(),
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

          BlocBuilder<SouthZeroBloc, SouthZeroState>(
            builder: (context, state) {
              final currentZone = SectionZones.southZero.toString();
              return ListTile(
                leading: const Icon(Icons.add),
                title: const Text("Add SouthZero Map"),
                onTap: () async {
                  final inputData = await handleAddMap(
                    context,
                    currentZone,
                    productNameController,
                    productIdController,
                    sectionIdController,
                    stockpileController,
                  );

                  if (productNameController.text.isEmpty ||
                      productIdController.text.isEmpty ||
                      sectionIdController.text.isEmpty ||
                      stockpileController.text.isEmpty) return;
                  if (inputData == null) return;
                  if (state is SouthZeroSuccessState) {
                    final newIndex =
                        state.mapData[(state.mapData.length) - 1].index + 1;
                    final newMap = MapData(
                      index: newIndex,
                      uid: "random number",
                      sectionId: inputData["sectionId"],
                      productId: inputData['productId'],
                      productName: inputData["projectName"],
                      createdAt: DateTime.now(),
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
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () async {
              await singleton<AuthRepository>().logout();
            },
          ),
        ],
      ),
    );
  }
}
