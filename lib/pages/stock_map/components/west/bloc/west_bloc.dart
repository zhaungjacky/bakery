import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_zero_bloc.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';

part 'west_event.dart';
part 'west_state.dart';

class WestBloc extends Bloc<WestEvent, WestState> {
  late StreamSubscription _streamSubscription;

  final MapDataRepo _mapDataRepo;

  WestBloc({required MapDataRepo mapDataRepo})
      : _mapDataRepo = mapDataRepo,
        super(WestInitial()) {
    _streamSubscription = _mapDataRepo
        .getMapData(
      SectionZones.west.name,
    )
        .listen((event) {
      // print(event.docs[0].id);
      final datas = event.docs
          .map(
            (map) => ZoneList.fromJson(map),
          )
          .toList();
      // print(datas[0].id);
      // print(datas[0].sectionId);
      // print(datas[0].list);
      add(WestLoadEvent(mapData: datas));
    });
    on<WestEvent>(
      (_, emit) => emit(
        WestInitial(),
      ),
    );
    on<WestLoadEvent>(_loadSuccess);
    on<WestAddEvent>(_addMap);
    on<WestUpdateIsCategoryEvent>(_updateIsCategory);
    on<WestRefreshCategoryEvent>(_refresh);
  }

  _loadSuccess(WestLoadEvent event, Emitter emit) {
    emit(
      WestSuccessState(mapData: event.mapData),
    );
  }

  _addMap(WestAddEvent event, Emitter emit) async {
    await _mapDataRepo.createMapData(event.data);
    // emit(WestSuccessState(mapData: mapData))
  }

  _updateIsCategory(WestUpdateIsCategoryEvent event, Emitter emit) {
    emit(
      WestSuccessState(mapData: event.mapData),
    );
  }

  _refresh(WestRefreshCategoryEvent event, Emitter emit) async {
    await _streamSubscription.cancel();
    _streamSubscription =
        _mapDataRepo.getMapData(SectionZones.west.name).listen((event) {
      final datas = event.docs
          .map(
            (map) => ZoneList.fromJson(map),
          )
          .toList();
      // print(datas[0].id);
      // print(datas[0].sectionId);
      add(
        WestLoadEvent(
          mapData: datas,
        ),
      );
    });
  }

  @override
  Future<void> close() async {
    super.close();
    _streamSubscription.cancel();
  }
}
