import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';

part 'north_zero_event.dart';
part 'north_zero_state.dart';

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
  late StreamSubscription _streamSubscription;

  final MapDataRepo _mapDataRepo;

  NorthZeroBloc({
    required MapDataRepo mapDataRepo,
  })  : _mapDataRepo = mapDataRepo,
        super(NorthZeroInitial()) {
    _streamSubscription = _mapDataRepo
        .getMapData(
      SectionZones.northZero.name,
    )
        .listen((event) {
      final lists = event.docs.map((item) => ZoneList.fromJson(item)).toList();
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
    on<NorthZeroUpdateIsCategoryEvent>(_updateIsCategory);
    on<NorthZeroRefreshCategoryEvent>(_refresh);
  }

  _loadingNorthMap(NorthZeroLoadingEvent event, Emitter emit) {
    emit(NorthZeroSuccessState(mapData: event.data));
  }

  _updateIsCategory(
    NorthZeroUpdateIsCategoryEvent event,
    Emitter emit,
  ) {
    emit(
      NorthZeroSuccessState(mapData: event.data),
    );
  }

  _refresh(NorthZeroRefreshCategoryEvent event, Emitter emit) async {
    await _streamSubscription.cancel();
    _streamSubscription =
        _mapDataRepo.getMapData(SectionZones.northZero.name).listen((event) {
      final data = event.docs
          .map(
            (map) => ZoneList.fromJson(map),
          )
          .toList();

      add(
        NorthZeroLoadingEvent(
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
