part of 'south_one_bloc.dart';

@immutable
sealed class SouthOneEvent {
  const SouthOneEvent();
}

class SouthOneLoadingEvent extends SouthOneEvent {
  final List<ZoneList> data;

  const SouthOneLoadingEvent({required this.data});
}

class SouthOneUpdateIsCategoryEvent extends SouthOneEvent {
  final List<ZoneList> data;

  const SouthOneUpdateIsCategoryEvent({
    required this.data,
  });
}

class SouthOneRefreshCategoryEvent extends SouthOneEvent {}
