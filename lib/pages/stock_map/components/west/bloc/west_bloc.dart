import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_bloc.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';

part 'west_event.dart';
part 'west_state.dart';

class WestBloc extends Bloc<WestEvent, WestState> {
  late final StreamSubscription _streamSubscription;

  final MapDataRepo _mapDataRepo;

  WestBloc({required MapDataRepo mapDataRepo})
      : _mapDataRepo = mapDataRepo,
        super(WestInitial()) {
    _streamSubscription =
        _mapDataRepo.getMapData(SectionZones.west.toString()).listen((event) {
      final datas = event.docs.map((map) => MapData.fromJson(map)).toList();
      add(WestLoadEvent(mapData: datas));
    });
    on<WestEvent>((_, emit) => emit(WestInitial()));
    on<WestLoadEvent>(_loadSuccess);
    on<WestAddEvent>(_addMap);
  }

  _loadSuccess(WestLoadEvent event, Emitter emit) {
    emit(WestSuccessState(mapData: event.mapData));
  }

  _addMap(WestAddEvent event, Emitter emit) async {
    await _mapDataRepo.createMapData("west", event.data);
    // emit(WestSuccessState(mapData: mapData))
  }

  @override
  Future<void> close() async {
    super.close();
    _streamSubscription.cancel();
  }
}
