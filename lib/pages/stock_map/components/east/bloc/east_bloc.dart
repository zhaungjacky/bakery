import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_zero_bloc.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';

part 'east_event.dart';
part 'east_state.dart';

class EastBloc extends Bloc<EastEvent, EastState> {
  late StreamSubscription _streamSubscription;

  final MapDataRepo _mapDataRepo;

  EastBloc({required MapDataRepo mapDataRepo})
      : _mapDataRepo = mapDataRepo,
        super(EastInitial()) {
    _streamSubscription = _mapDataRepo
        .getMapData(
      SectionZones.east.name,
    )
        .listen((event) {
      final datas = event.docs.map((map) => ZoneList.fromJson(map)).toList();
      add(
        EastLoadEvent(mapData: datas),
      );
    });
    on<EastEvent>((_, emit) => emit(EastInitial()));
    on<EastLoadEvent>(_loadSuccess);
    on<EastUpdateIsCategoryEvent>(_updateIsCategory);
    on<EastRefreshCategoryEvent>(_refresh);
  }

  _loadSuccess(EastLoadEvent event, Emitter emit) {
    emit(EastSuccessState(mapData: event.mapData));
  }

  _updateIsCategory(EastUpdateIsCategoryEvent event, Emitter emit) {
    emit(
      EastSuccessState(mapData: event.mapData),
    );
  }

  _refresh(EastRefreshCategoryEvent event, Emitter emit) async {
    await _streamSubscription.cancel();
    _streamSubscription =
        _mapDataRepo.getMapData(SectionZones.east.name).listen((event) {
      final datas = event.docs.map((map) => ZoneList.fromJson(map)).toList();
      add(
        EastLoadEvent(mapData: datas),
      );
    });
  }

  @override
  Future<void> close() async {
    super.close();
    _streamSubscription.cancel();
  }
}
