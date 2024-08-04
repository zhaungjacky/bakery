part of 'south_one_bloc.dart';

@immutable
sealed class SouthOneEvent {
  const SouthOneEvent();
}

class SouthOneLoadingEvent extends SouthOneEvent {
  final List<MapData> data;

  const SouthOneLoadingEvent({required this.data});
}
