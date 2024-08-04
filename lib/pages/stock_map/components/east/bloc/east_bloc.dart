import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_bloc.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/models/map_data.dart';

part 'east_event.dart';
part 'east_state.dart';

class EastBloc extends Bloc<EastEvent, EastState> {
  late final StreamSubscription _streamSubscription;

  final MapDataRepo _mapDataRepo;

  EastBloc({required MapDataRepo mapDataRepo})
      : _mapDataRepo = mapDataRepo,
        super(EastInitial()) {
    _streamSubscription =
        _mapDataRepo.getMapData(SectionZones.east.toString()).listen((event) {
      final datas = event.docs.map((map) => MapData.fromJson(map)).toList();
      add(EastLoadEvent(mapData: datas));
    });
    on<EastEvent>((_, emit) => emit(EastInitial()));
    on<EastLoadEvent>(_loadSuccess);
  }

  _loadSuccess(EastLoadEvent event, Emitter emit) {
    emit(EastSuccessState(mapData: event.mapData));
  }

  @override
  Future<void> close() async {
    super.close();
    _streamSubscription.cancel();
  }
}
