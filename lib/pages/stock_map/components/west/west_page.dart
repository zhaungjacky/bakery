import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/stock_map/components/west/bloc/west_bloc.dart';
import 'package:superstore/pages/stock_map/components/east_west_component_page.dart';

class WestSectionPage extends StatelessWidget {
  final double width;
  const WestSectionPage({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WestBloc, WestState>(
      builder: (context, state) {
        switch (state) {
          case WestInitial():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case WestSuccessState():
            final data = state.mapData;
            // print(data.productName);
            return EastWestComponentPage(
              data: data,
              width: width,
            );
          case WestFailureState():
            return const Center(
              child: Text("error"),
            );
          case WestErrorState():
            return Center(
              child: Text(state.message),
            );
        }
      },
    );
  }
}
