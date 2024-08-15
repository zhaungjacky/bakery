part of 'north_one_bloc.dart';

@immutable
sealed class NorthOneEvent {
  const NorthOneEvent();
}

class NorthOneLoadingEvent extends NorthOneEvent {
  final List<ZoneList> data;

  const NorthOneLoadingEvent({required this.data});
}

class NorthOneUpdateIsCategoryEvent extends NorthOneEvent {
  final List<ZoneList> mapData;

  const NorthOneUpdateIsCategoryEvent({
    required this.mapData,
  });
}

class NorthOneRefreshCategoryEvent extends NorthOneEvent {}
