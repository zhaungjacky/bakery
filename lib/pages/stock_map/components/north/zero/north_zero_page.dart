import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_zero_bloc.dart';
import 'package:superstore/pages/stock_map/components/north_south_component.dart';

class NorthZeroSectionPage extends StatelessWidget {
  const NorthZeroSectionPage({
    super.key,
    required this.height,
    required this.fontSize,
  });
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NorthZeroBloc, NorthZeroState>(
      builder: (context, state) {
        switch (state) {
          case NorthZeroInitial():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case NorthZeroSuccessState():
            final items = state.mapData;
            // print(items[0].productName);
            // print(items[0].sectionId);
            return NorthSouthComponentPage(
              items: items,
              height: height,
              fontSize: fontSize,
            );
          case NorthZeroFailureState():
            return const Center(
              child: Text("error"),
            );
          case NorthZeroErrorState():
            return Center(
              child: Text(state.message),
            );
        }
      },
    );
  }
}
