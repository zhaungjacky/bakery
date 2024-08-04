import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_bloc.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';

part 'map_data_event.dart';
part 'map_data_state.dart';

class MapDataBloc extends Bloc<MapDataEvent, MapDataState> {
  final SectionZones _zone;

  late final StreamSubscription _streamSubscription;

  final MapDataRepo _mapDataRepo;

  MapDataBloc({
    required MapDataRepo mapDataRepo,
    required SectionZones zone,
  })  : _mapDataRepo = mapDataRepo,
        _zone = zone,
        super(MapDataInitial()) {
    _streamSubscription =
        _mapDataRepo.getMapData(_zone.toString()).listen((event) {
      final lists = event.docs.map((item) => MapData.fromJson(item)).toList();
      add(MapDataLoadingEvent(mapData: lists));
    });

    on<MapDataEvent>(
      (_, emit) => emit(
        MapDataInitial(),
      ),
    );
    on<MapDataLoadingEvent>(_loadingNorthMap);
  }

  _loadingNorthMap(MapDataLoadingEvent event, Emitter emit) {
    emit(MapDataSuccessState(
      mapData: event.mapData,
    ));
  }

  @override
  Future<void> close() async {
    super.close();

    await _streamSubscription.cancel();
  }
}
