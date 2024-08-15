part of 'north_zero_bloc.dart';

@immutable
sealed class NorthZeroEvent {
  const NorthZeroEvent();
}

class NorthZeroLoadingEvent extends NorthZeroEvent {
  final List<ZoneList> data;

  const NorthZeroLoadingEvent({required this.data});
}

class NorthZeroUpdateIsCategoryEvent extends NorthZeroEvent {
  final List<ZoneList> data;

  const NorthZeroUpdateIsCategoryEvent({
    required this.data,
  });
}

class NorthZeroRefreshCategoryEvent extends NorthZeroEvent {}
