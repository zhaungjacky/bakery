import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superstore/services/serverice-model/service_repo.dart';
import 'package:superstore/services/tags/model/tag_model.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  late StreamSubscription _streamSubscription;
  final ServiceRepo<TagModel> _serviceRepo;
  TagsBloc({
    required ServiceRepo<TagModel> serviceRepo,
  })  : _serviceRepo = serviceRepo,
        super(
          TagsInitial(),
        ) {
    _streamSubscription = _serviceRepo.getItems().listen((event) {
      final list = event.docs.map((doc) => TagModel.fromJson(doc)).toList();
      add(
        TagsLoadEvent(list: list),
      );
    });
    on<TagsEvent>(
      (_, emit) => emit(
        TagsInitial(),
      ),
    );
    on<TagsLoadEvent>(_load);
    on<TagsRefreshEvent>(_refresh);
    on<TagsUpdateFoundCategoryEvent>(_update);
  }

  _update(
    TagsUpdateFoundCategoryEvent event,
    Emitter emit,
  ) {
    emit(
      TagsSuccessState(list: event.list),
    );
  }

  _refresh(
    TagsRefreshEvent event,
    Emitter emit,
  ) async {
    await _streamSubscription.cancel();

    _streamSubscription = _serviceRepo.getItems().listen((event) {
      final list = event.docs.map((doc) => TagModel.fromJson(doc)).toList();
      add(
        TagsLoadEvent(list: list),
      );
    });
  }

  _load(
    TagsLoadEvent event,
    Emitter emit,
  ) {
    emit(
      TagsSuccessState(list: event.list),
    );
  }

  @override
  Future<void> close() async {
    super.close();
    await _streamSubscription.cancel();
  }
}
