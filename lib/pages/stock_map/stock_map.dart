import 'package:flutter/material.dart';
import 'package:superstore/pages/components/my_drawer.dart';
import 'package:superstore/pages/components/search_func.dart';
import 'package:superstore/pages/stock_map/components/components.dart';

class StockMapPage extends StatelessWidget {
  const StockMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const heights = [0.1, 0.075, 0.7, 0.1];
    const widths = [0.225, 0.05, 0.225, 0.225, 0.05, 0.225];
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Map"),
        centerTitle: true,
        elevation: 1,
        actions: [
          SearchFunciton(searchController: searchController),
        ],
      ),
      drawer: const SafeArea(
        child: MyDrawer(),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //ACE -west
            Container(
              width: screenWidth,
              height: screenHeight * heights[0],
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: WestSectionPage(
                width: screenWidth,
              ),
            ),

            Container(
              width: screenWidth,
              height: screenHeight * heights[1],
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: const Center(child: Text("Road")),
            ),
            //middle
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  //commerical bread-line -one
                  Container(
                    width: screenWidth * widths[0],
                    height: screenHeight * heights[2],
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: const SouthZeroSectionPage(),
                  ),
                  Container(
                    width: screenWidth * widths[1],
                    height: screenHeight * heights[2],
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: const Center(
                      child: Text(
                        "road",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),

                  Container(
                    width: screenWidth * widths[2],
                    height: screenHeight * heights[2],
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: const SouthOneSectionPage(),
                  ),
                  Container(
                    width: screenWidth * widths[3],
                    height: screenHeight * heights[2],
                    decoration: const BoxDecoration(
                      color: Colors.brown,
                    ),
                    child: const NorthOneSectionPage(),
                  ),
                  Container(
                    width: screenWidth * widths[4],
                    height: screenHeight * heights[2],
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: const Center(
                      child: Text(
                        "road",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * widths[5],
                    height: screenHeight * (heights[2] + 0.1),
                    decoration: const BoxDecoration(
                      color: Colors.brown,
                    ),
                    // child: const Text("dasd"),
                    child: const NorthZeroSectionPage(),
                  ),
                ],
              ),
            ),
            //east
            Container(
              width: screenWidth,
              height: screenHeight * heights[3],
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: EastSectionPage(
                width: screenWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
