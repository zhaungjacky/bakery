import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_zero_bloc.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';

part 'south_one_event.dart';
part 'south_one_state.dart';

class SouthOneBloc extends Bloc<SouthOneEvent, SouthOneState> {
  late StreamSubscription _streamSubscription;

  final MapDataRepo _mapDataRepo;

  SouthOneBloc({
    required MapDataRepo mapDataRepo,
  })  : _mapDataRepo = mapDataRepo,
        super(SouthOneInitial()) {
    _streamSubscription = _mapDataRepo
        .getMapData(
      SectionZones.southOne.name,
    )
        .listen((event) {
      final lists = event.docs.map((item) => ZoneList.fromJson(item)).toList();
      add(
        SouthOneLoadingEvent(data: lists),
      );
    });
    on<SouthOneEvent>(
      (_, emit) => emit(
        SouthOneInitial(),
      ),
    );
    on<SouthOneLoadingEvent>(_loadingSouthMap);
    on<SouthOneUpdateIsCategoryEvent>(_updateIsCategory);
    on<SouthOneRefreshCategoryEvent>(_refresh);
  }

  _loadingSouthMap(SouthOneLoadingEvent event, Emitter emit) {
    emit(SouthOneSuccessState(mapData: event.data));
  }

  _updateIsCategory(
    SouthOneUpdateIsCategoryEvent event,
    Emitter emit,
  ) {
    emit(
      SouthOneSuccessState(mapData: event.data),
    );
  }

  _refresh(SouthOneRefreshCategoryEvent event, Emitter emit) async {
    await _streamSubscription.cancel();
    _streamSubscription =
        _mapDataRepo.getMapData(SectionZones.southOne.name).listen((event) {
      final data = event.docs
          .map(
            (map) => ZoneList.fromJson(map),
          )
          .toList();

      add(
        SouthOneLoadingEvent(
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
