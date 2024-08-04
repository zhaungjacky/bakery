part of 'east_bloc.dart';

@immutable
sealed class EastEvent {
  const EastEvent();
}

class EastLoadEvent extends EastEvent {
  final List<MapData> mapData;

  const EastLoadEvent({required this.mapData});
}
