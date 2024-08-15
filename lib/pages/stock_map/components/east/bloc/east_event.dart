part of 'east_bloc.dart';

@immutable
sealed class EastEvent {
  const EastEvent();
}

class EastLoadEvent extends EastEvent {
  final List<ZoneList> mapData;

  const EastLoadEvent({required this.mapData});
}

class EastUpdateIsCategoryEvent extends EastEvent {
  final List<ZoneList> mapData;

  const EastUpdateIsCategoryEvent({
    required this.mapData,
  });
}

class EastRefreshCategoryEvent extends EastEvent {}
