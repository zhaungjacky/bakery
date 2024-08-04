part of 'map_data_bloc.dart';

@immutable
sealed class MapDataEvent {
  const MapDataEvent();
}

class MapDataLoadingEvent extends MapDataEvent {
  final List<MapData> mapData;

  const MapDataLoadingEvent({required this.mapData});
}
