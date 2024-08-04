part of 'north_bloc.dart';

@immutable
sealed class NorthZeroState {
  const NorthZeroState();
}

final class NorthZeroInitial extends NorthZeroState {}

class NorthZeroSuccessState extends NorthZeroState {
  final List<MapData> mapData;

  const NorthZeroSuccessState({required this.mapData});
}

class NorthZeroFailureState extends NorthZeroState {}

class NorthZeroErrorState extends NorthZeroState {
  final String message;

  const NorthZeroErrorState({required this.message});
}
