import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/stock_map/components/north_south_component.dart';
import 'package:superstore/pages/stock_map/components/south/zero/bloc/south_zero_bloc.dart';

class SouthZeroSectionPage extends StatelessWidget {
  const SouthZeroSectionPage({
    super.key,
    required this.height,
    required this.fontSize,
  });
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SouthZeroBloc, SouthZeroState>(
      builder: (context, state) {
        switch (state) {
          case SouthZeroInitial():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case SouthZeroSuccessState():
            final items = state.mapData;
            // print(items[0].productName);
            // print(items[0].sectionId);
            return NorthSouthComponentPage(
              items: items,
              height: height,
              fontSize: fontSize,
            );
          case SouthZeroFailureState():
            return const Center(
              child: Text("error"),
            );
          case SouthZeroErrorState():
            return Center(
              child: Text(state.message),
            );
        }
      },
    );
  }
}
