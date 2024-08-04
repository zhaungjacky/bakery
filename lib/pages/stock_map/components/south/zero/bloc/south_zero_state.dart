part of 'south_zero_bloc.dart';

@immutable
sealed class SouthZeroState {
  const SouthZeroState();
}

final class SouthZeroInitial extends SouthZeroState {}

class SouthZeroSuccessState extends SouthZeroState {
  final List<MapData> mapData;

  const SouthZeroSuccessState({required this.mapData});
}

class SouthZeroFailureState extends SouthZeroState {}

class SouthZeroErrorState extends SouthZeroState {
  final String message;

  const SouthZeroErrorState({required this.message});
}
