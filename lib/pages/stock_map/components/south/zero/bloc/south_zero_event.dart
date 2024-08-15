part of 'south_zero_bloc.dart';

@immutable
sealed class SouthZeroEvent {
  const SouthZeroEvent();
}

class SouthZeroLoadingEvent extends SouthZeroEvent {
  final List<ZoneList> data;

  const SouthZeroLoadingEvent({required this.data});
}

class SouthZeroUpdateIsCategoryEvent extends SouthZeroEvent {
  final List<ZoneList> data;

  const SouthZeroUpdateIsCategoryEvent({
    required this.data,
  });
}

class SouthZeroRefreshCategoryEvent extends SouthZeroEvent {}
