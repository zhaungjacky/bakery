part of 'north_one_bloc.dart';

@immutable
sealed class NorthOneState {
  const NorthOneState();
}

final class NorthOneInitial extends NorthOneState {}

class NorthOneSuccessState extends NorthOneState {
  final List<MapData> mapData;

  const NorthOneSuccessState({required this.mapData});
}

class NorthOneFailureState extends NorthOneState {}

class NorthOneErrorState extends NorthOneState {
  final String message;

  const NorthOneErrorState({required this.message});
}
