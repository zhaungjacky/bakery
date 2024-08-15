part of 'tags_bloc.dart';

@immutable
sealed class TagsEvent {
  const TagsEvent();
}

class TagsLoadEvent extends TagsEvent {
  final List<TagModel> list;

  const TagsLoadEvent({
    required this.list,
  });
}

class TagsUpdateFoundCategoryEvent extends TagsEvent {
  final List<TagModel> list;

  const TagsUpdateFoundCategoryEvent({
    required this.list,
  });
}

class TagsRefreshEvent extends TagsEvent {}
