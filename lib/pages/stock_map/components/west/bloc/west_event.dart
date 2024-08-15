part of 'west_bloc.dart';

@immutable
sealed class WestEvent {
  const WestEvent();
}

class WestLoadEvent extends WestEvent {
  final List<ZoneList> mapData;

  const WestLoadEvent({
    required this.mapData,
  });
}

class WestAddEvent extends WestEvent {
  final MapData data;

  const WestAddEvent({required this.data});
}

class WestUpdateIsCategoryEvent extends WestEvent {
  final List<ZoneList> mapData;

  const WestUpdateIsCategoryEvent({
    required this.mapData,
  });
}

class WestRefreshCategoryEvent extends WestEvent {}
