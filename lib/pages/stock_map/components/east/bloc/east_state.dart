part of 'east_bloc.dart';

@immutable
sealed class EastState {
  const EastState();
}

final class EastInitial extends EastState {}

class EastSuccessState extends EastState {
  final List<MapData> mapData;

  const EastSuccessState({required this.mapData});
}

class EastFailureState extends EastState {}

class EastErrorState extends EastState {
  final String message;

  const EastErrorState({required this.message});
}
