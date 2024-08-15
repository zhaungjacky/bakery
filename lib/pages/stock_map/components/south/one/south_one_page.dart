import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/stock_map/components/north_south_component.dart';
import 'package:superstore/pages/stock_map/components/south/one/bloc/south_one_bloc.dart';

class SouthOneSectionPage extends StatelessWidget {
  const SouthOneSectionPage({
    super.key,
    required this.height,
    required this.fontSize,
  });
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SouthOneBloc, SouthOneState>(
      builder: (context, state) {
        switch (state) {
          case SouthOneInitial():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case SouthOneSuccessState():
            final items = state.mapData;
            // print(items[0].productName);
            // print(items[0].sectionId);
            return NorthSouthComponentPage(
              items: items,
              height: height,
              fontSize: fontSize,
            );
          case SouthOneFailureState():
            return const Center(
              child: Text("error"),
            );
          case SouthOneErrorState():
            return Center(
              child: Text(state.message),
            );
        }
      },
    );
  }
}
