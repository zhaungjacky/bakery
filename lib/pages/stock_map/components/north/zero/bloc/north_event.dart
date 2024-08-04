part of 'north_bloc.dart';

@immutable
sealed class NorthZeroEvent {
  const NorthZeroEvent();
}

class NorthZeroLoadingEvent extends NorthZeroEvent {
  final List<MapData> data;

  const NorthZeroLoadingEvent({required this.data});
}
