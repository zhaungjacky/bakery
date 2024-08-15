import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_zero_bloc.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';

part 'north_one_event.dart';
part 'north_one_state.dart';

class NorthOneBloc extends Bloc<NorthOneEvent, NorthOneState> {
  late StreamSubscription _streamSubscription;

  final MapDataRepo _mapDataRepo;

  NorthOneBloc({
    required MapDataRepo mapDataRepo,
  })  : _mapDataRepo = mapDataRepo,
        super(NorthOneInitial()) {
    _streamSubscription = _mapDataRepo
        .getMapData(
      SectionZones.northOne.name,
    )
        .listen((event) {
      final lists = event.docs.map((item) => ZoneList.fromJson(item)).toList();
      add(
        NorthOneLoadingEvent(data: lists),
      );
    });
    on<NorthOneEvent>(
      (_, emit) => emit(
        NorthOneInitial(),
      ),
    );
    on<NorthOneLoadingEvent>(_loadingNorthMap);
    on<NorthOneUpdateIsCategoryEvent>(_updateIsCategory);
    on<NorthOneRefreshCategoryEvent>(_refresh);
  }

  _loadingNorthMap(NorthOneLoadingEvent event, Emitter emit) {
    emit(NorthOneSuccessState(mapData: event.data));
  }

  _updateIsCategory(NorthOneUpdateIsCategoryEvent event, Emitter emit) {
    emit(
      NorthOneSuccessState(mapData: event.mapData),
    );
  }

  _refresh(NorthOneRefreshCategoryEvent event, Emitter emit) async {
    await _streamSubscription.cancel();
    _streamSubscription =
        _mapDataRepo.getMapData(SectionZones.northOne.name).listen((event) {
      final data = event.docs
          .map(
            (map) => ZoneList.fromJson(map),
          )
          .toList();

      add(
        NorthOneLoadingEvent(
          data: data,
        ),
      );
    });
  }

  @override
  Future<void> close() async {
    super.close();

    await _streamSubscription.cancel();
  }
}
