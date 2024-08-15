import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/components/my_drawer.dart';
import 'package:superstore/pages/components/search_func.dart';
import 'package:superstore/pages/settings/bloc/settings_bloc.dart';
import 'package:superstore/pages/stock_map/components/components.dart';

class StockMapPage extends StatefulWidget {
  const StockMapPage({super.key});

  @override
  State<StockMapPage> createState() => _StockMapPageState();
}

class _StockMapPageState extends State<StockMapPage> {
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // const heights = [0.1, 0.635, 0.1];
    // const widths = [0.225, 0.05, 0.225, 0.225, 0.05, 0.225];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Map"),
        centerTitle: true,
        elevation: 1,
        actions: [
          SearchFunciton(
            searchController: searchController,
          ),
        ],
      ),
      drawer: const SafeArea(
        child: MyDrawer(),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingSuccessState) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //ACE -west
                  WestSection(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    heights: state.setting.heightsPercentList,
                    fontSize: state.setting.fontSize,
                  ),

                  MiddleSection(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    widthList: state.setting.widthPercentList,
                    heightList: state.setting.heightsPercentList,
                    fontSize: state.setting.fontSize,
                  ),

                  //east
                  EastSection(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    heights: state.setting.heightsPercentList,
                    fontSize: state.setting.fontSize,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}

class MiddleSection extends StatelessWidget {
  const MiddleSection({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.widthList,
    required this.heightList,
    required this.fontSize,
  });

  final double screenWidth;
  final double screenHeight;
  final List<double> widthList;
  final List<double> heightList;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Expanded(
          flex: 7,
          //middle
          child: Row(
            children: [
              // except for northZero
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.05,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Center(
                        child: Text(
                          "Road",
                          style: TextStyle(
                            fontSize: fontSize,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          //south-zero
                          Container(
                            width: screenWidth * widthList[0],
                            height: screenHeight * heightList[1],
                            padding: const EdgeInsets.only(
                              left: 3,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: SouthZeroSectionPage(
                              height: screenHeight * heightList[1],
                              fontSize: fontSize,
                            ),
                          ),

                          //road
                          Container(
                            width: screenWidth * widthList[1],
                            height: screenHeight * heightList[1],
                            decoration: const BoxDecoration(
                              color: Colors.green,
                            ),
                            child: Center(
                              child: Text(
                                "",
                                style: TextStyle(
                                  fontSize: fontSize,
                                ),
                              ),
                            ),
                          ),
                          //south-one
                          Container(
                            width: screenWidth * widthList[2],
                            height: screenHeight * heightList[1],
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: SouthOneSectionPage(
                              height: screenHeight * heightList[1],
                              fontSize: fontSize,
                            ),
                          ),
                          //north-one
                          Container(
                            width: screenWidth * widthList[3],
                            height: screenHeight * heightList[1],
                            decoration: const BoxDecoration(
                              color: Colors.brown,
                            ),
                            child: NorthOneSectionPage(
                              height: screenHeight * heightList[1],
                              fontSize: fontSize,
                            ),
                          ),

                          //road
                          Container(
                            width: screenWidth * widthList[4],
                            height: screenHeight * heightList[1],
                            decoration: const BoxDecoration(
                              color: Colors.green,
                            ),
                            child: const Center(
                              child: Text(
                                "",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // northZero
              Container(
                width: screenWidth * widthList[5],
                height: screenHeight * (0.71),
                padding: const EdgeInsets.only(
                  right: 3,
                ),
                decoration: const BoxDecoration(
                  color: Colors.brown,
                ),
                // child: const Text("dasd"),
                child: NorthZeroSectionPage(
                  height: screenHeight * (heightList[1] + 0.05),
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class EastSection extends StatelessWidget {
  const EastSection({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.heights,
    required this.fontSize,
  });

  final double screenWidth;
  final double screenHeight;
  final List<double> heights;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight * heights[2],
      padding: const EdgeInsets.only(
        left: 3,
        right: 3,
      ),
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: EastSectionPage(
        width: screenWidth,
        fontSize: fontSize,
      ),
    );
  }
}

class WestSection extends StatelessWidget {
  const WestSection({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.heights,
    required this.fontSize,
  });

  final double screenWidth;
  final double screenHeight;
  final List<double> heights;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight * heights[0],
      padding: const EdgeInsets.only(
        left: 3,
        right: 3,
      ),
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: WestSectionPage(
        width: screenWidth,
        fontSize: fontSize,
      ),
    );
  }
}


/*
class MiddleSection extends StatelessWidget {
  const MiddleSection({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.widths,
    required this.heights,
  });

  final double screenWidth;
  final double screenHeight;
  final List<double> widths;
  final List<double> heights;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Stack(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.05,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: const Center(child: Text("Road")),
                ),
                Expanded(
                  child: Row(
                    children: [
                      //south-zero
                      Container(
                        width: screenWidth * widths[0],
                        height: screenHeight * heights[1],
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: SouthZeroSectionPage(
                          height: screenHeight * heights[1],
                        ),
                      ),

                      //road
                      Container(
                        width: screenWidth * widths[1],
                        height: screenHeight * heights[1],
                        decoration: const BoxDecoration(
                          color: Colors.green,
                        ),
                        child: const Center(
                          child: Text(
                            "",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      //south-one
                      Container(
                        width: screenWidth * widths[2],
                        height: screenHeight * heights[1],
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: SouthOneSectionPage(
                          height: screenHeight * heights[1],
                        ),
                      ),
                      //north-one
                      Container(
                        width: screenWidth * widths[3],
                        height: screenHeight * heights[1],
                        decoration: const BoxDecoration(
                          color: Colors.brown,
                        ),
                        child: NorthOneSectionPage(
                          height: screenHeight * heights[1],
                        ),
                      ),

                      //road
                      Container(
                        width: screenWidth * widths[4],
                        height: screenHeight * heights[1],
                        decoration: const BoxDecoration(
                          color: Colors.green,
                        ),
                        child: const Center(
                          child: Text(
                            "",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //middle
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: screenWidth * widths[5],
              height: screenHeight * (0.8),
              padding: const EdgeInsets.only(
                right: 3,
              ),
              decoration: const BoxDecoration(
                color: Colors.brown,
              ),
              // child: const Text("dasd"),
              child: NorthZeroSectionPage(
                height: screenHeight * (0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 */