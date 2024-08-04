import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';

part 'north_event.dart';
part 'north_state.dart';

enum SectionZones {
  west,
  east,
  northZero,
  northOne,
  southZero,
  southOne,
  road,
}

class NorthZeroBloc extends Bloc<NorthZeroEvent, NorthZeroState> {
  late final StreamSubscription _streamSubscription;

  final MapDataRepo _mapDataRepo;

  NorthZeroBloc({
    required MapDataRepo mapDataRepo,
  })  : _mapDataRepo = mapDataRepo,
        super(NorthZeroInitial()) {
    _streamSubscription = _mapDataRepo
        .getMapData(
      SectionZones.northZero.toString(),
    )
        .listen((event) {
      final lists = event.docs.map((item) => MapData.fromJson(item)).toList();
      add(
        NorthZeroLoadingEvent(data: lists),
      );
    });
    on<NorthZeroEvent>(
      (_, emit) => emit(
        NorthZeroInitial(),
      ),
    );
    on<NorthZeroLoadingEvent>(_loadingNorthMap);
  }

  _loadingNorthMap(NorthZeroLoadingEvent event, Emitter emit) {
    emit(NorthZeroSuccessState(mapData: event.data));
  }

  @override
  Future<void> close() async {
    super.close();

    await _streamSubscription.cancel();
  }
}
