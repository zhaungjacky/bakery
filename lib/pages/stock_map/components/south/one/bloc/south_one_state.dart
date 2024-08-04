part of 'south_one_bloc.dart';

@immutable
sealed class SouthOneState {
  const SouthOneState();
}

final class SouthOneInitial extends SouthOneState {}

class SouthOneSuccessState extends SouthOneState {
  final List<MapData> mapData;

  const SouthOneSuccessState({required this.mapData});
}

class SouthOneFailureState extends SouthOneState {}

class SouthOneErrorState extends SouthOneState {
  final String message;

  const SouthOneErrorState({required this.message});
}
