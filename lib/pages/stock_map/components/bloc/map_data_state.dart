part of 'map_data_bloc.dart';

@immutable
sealed class MapDataState {
  const MapDataState();
}

final class MapDataInitial extends MapDataState {}

class MapDataSuccessState extends MapDataState {
  final List<MapData> mapData;

  const MapDataSuccessState({required this.mapData});
}

class MapDataFailureState extends MapDataState {}

class MapDataErrorState extends MapDataState {
  final String message;

  const MapDataErrorState({required this.message});
}
