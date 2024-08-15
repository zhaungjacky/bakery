import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/one/bloc/north_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/north_south_component.dart';

class NorthOneSectionPage extends StatelessWidget {
  const NorthOneSectionPage({
    super.key,
    required this.height,
    required this.fontSize,
  });
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NorthOneBloc, NorthOneState>(
      builder: (context, state) {
        switch (state) {
          case NorthOneInitial():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case NorthOneSuccessState():
            final items = state.mapData;
            // print(items[0].productName);
            // print(items[0].sectionId);
            return NorthSouthComponentPage(
              items: items,
              height: height,
              fontSize: fontSize,
            );
          case NorthOneFailureState():
            return const Center(
              child: Text("error"),
            );
          case NorthOneErrorState():
            return Center(
              child: Text(state.message),
            );
        }
      },
    );
  }
}
