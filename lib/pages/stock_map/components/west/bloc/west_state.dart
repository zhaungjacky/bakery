part of 'west_bloc.dart';

@immutable
sealed class WestState {
  const WestState();
}

final class WestInitial extends WestState {}

class WestSuccessState extends WestState {
  final List<MapData> mapData;

  const WestSuccessState({required this.mapData});
}

class WestFailureState extends WestState {}

class WestErrorState extends WestState {
  final String message;

  const WestErrorState({required this.message});
}
