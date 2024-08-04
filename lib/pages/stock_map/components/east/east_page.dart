import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/stock_map/components/east/bloc/east_bloc.dart';
import 'package:superstore/pages/stock_map/components/east_west_component_page.dart';

class EastSectionPage extends StatelessWidget {
  final double width;
  const EastSectionPage({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EastBloc, EastState>(
      builder: (context, state) {
        switch (state) {
          case EastInitial():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case EastSuccessState():
            final data = state.mapData;
            // print(data.productName);
            return EastWestComponentPage(
              data: data,
              width: width,
            );
          case EastFailureState():
            return const Center(
              child: Text("error"),
            );
          case EastErrorState():
            return Center(
              child: Text(state.message),
            );
        }
      },
    );
  }
}
