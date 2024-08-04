part of 'south_zero_bloc.dart';

@immutable
sealed class SouthZeroEvent {
  const SouthZeroEvent();
}

class SouthZeroLoadingEvent extends SouthZeroEvent {
  final List<MapData> data;

  const SouthZeroLoadingEvent({required this.data});
}
