part of 'north_one_bloc.dart';

@immutable
sealed class NorthOneEvent {
  const NorthOneEvent();
}

class NorthOneLoadingEvent extends NorthOneEvent {
  final List<MapData> data;

  const NorthOneLoadingEvent({required this.data});
}
