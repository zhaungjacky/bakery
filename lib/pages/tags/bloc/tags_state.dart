part of 'tags_bloc.dart';

@immutable
sealed class TagsState {
  const TagsState();
}

final class TagsInitial extends TagsState {}

final class TagsSuccessState extends TagsState {
  final List<TagModel> list;
  const TagsSuccessState({
    required this.list,
  });
}

final class TagsFailureOrErrorState extends TagsState {
  final String message;
  const TagsFailureOrErrorState({
    required this.message,
  });
}
