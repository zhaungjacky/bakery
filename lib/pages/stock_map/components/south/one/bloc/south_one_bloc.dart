import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_bloc.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';

part 'south_one_event.dart';
part 'south_one_state.dart';

class SouthOneBloc extends Bloc<SouthOneEvent, SouthOneState> {
  late final StreamSubscription _streamSubscription;

  final MapDataRepo _mapDataRepo;

  SouthOneBloc({
    required MapDataRepo mapDataRepo,
  })  : _mapDataRepo = mapDataRepo,
        super(SouthOneInitial()) {
    _streamSubscription = _mapDataRepo
        .getMapData(
      SectionZones.southOne.toString(),
    )
        .listen((event) {
      final lists = event.docs.map((item) => MapData.fromJson(item)).toList();
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
  }

  _loadingSouthMap(SouthOneLoadingEvent event, Emitter emit) {
    emit(SouthOneSuccessState(mapData: event.data));
  }

  @override
  Future<void> close() async {
    super.close();

    await _streamSubscription.cancel();
  }
}
