import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_zero_bloc.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';

part 'south_zero_event.dart';
part 'south_zero_state.dart';

class SouthZeroBloc extends Bloc<SouthZeroEvent, SouthZeroState> {
  late StreamSubscription _streamSubscription;

  final MapDataRepo _mapDataRepo;

  SouthZeroBloc({
    required MapDataRepo mapDataRepo,
  })  : _mapDataRepo = mapDataRepo,
        super(SouthZeroInitial()) {
    _streamSubscription = _mapDataRepo
        .getMapData(
      SectionZones.southZero.name,
    )
        .listen((event) {
      final lists = event.docs.map((item) => ZoneList.fromJson(item)).toList();
      add(
        SouthZeroLoadingEvent(data: lists),
      );
    });
    on<SouthZeroEvent>(
      (_, emit) => emit(
        SouthZeroInitial(),
      ),
    );
    on<SouthZeroLoadingEvent>(_loadingSouthMap);
    on<SouthZeroUpdateIsCategoryEvent>(_updateIsCategory);
    on<SouthZeroRefreshCategoryEvent>(_refresh);
  }

  _loadingSouthMap(SouthZeroLoadingEvent event, Emitter emit) {
    emit(SouthZeroSuccessState(mapData: event.data));
  }

  _updateIsCategory(
    SouthZeroUpdateIsCategoryEvent event,
    Emitter emit,
  ) {
    emit(
      SouthZeroSuccessState(mapData: event.data),
    );
  }

  _refresh(SouthZeroRefreshCategoryEvent event, Emitter emit) async {
    await _streamSubscription.cancel();
    _streamSubscription =
        _mapDataRepo.getMapData(SectionZones.southZero.name).listen((event) {
      final data = event.docs
          .map(
            (map) => ZoneList.fromJson(map),
          )
          .toList();

      add(
        SouthZeroLoadingEvent(
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
