import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_repository/media_repository.dart';
import 'package:user_repository/user_repository.dart';

export 'package:media_repository/media_repository.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

part 'discover_state.dart';

/// Maneja la lógica del recurso [BaseMedia] mediante [MediaRepository].
class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit(
    this._mediaRepository,
    this._userRepository,
  ) : super(DiscoverState());

  final MediaRepository _mediaRepository;
  final UserRepository _userRepository;

  /// Busca en el repositorio la [BaseMedia] del usuario actual.
  ///
  /// Usa [state.status] para saber el estado que este tiene y
  /// [state.baseMedia] para utilizar la [BaseMedia] actual, estará
  /// disponible si [state.status] es [MediaStatus.success].
  Future<void> fetchMedia(TypeOfMedia type) async {
    emit(state.copyWith(status: MediaStatus.loading));
    try {
      final media = await _mediaRepository.get(type);
      emit(state.copyWith(media: media, status: MediaStatus.success));
    } on Exception {
      emit(state.copyWith(status: MediaStatus.failure));
    }
  }

  Future<void> likeMedia(int index) async {
    late final List<Doc>? docs = state.media?.baseMedia.docs;
    if (docs == null) return;
    final copyOfDocs = List.of(docs);
    final prevDoc = copyOfDocs[index];
    final youLikedThis = !(prevDoc.youLikedThis ?? false);
    final likes = (prevDoc.likes ?? 0) + 1;
    final newDoc = prevDoc.copyWith(youLikedThis: youLikedThis, likes: likes);
    copyOfDocs[index] = newDoc;
    try {
      await _mediaRepository.makeLike(prevDoc);
      final baseMediaCopy = state.media?.baseMedia.copyWith(docs: copyOfDocs);
      final media = state.media?.copyWith(baseMedia: baseMediaCopy);
      emit(state.copyWith(media: media, status: MediaStatus.success));
    } on Exception {
      emit(state.copyWith(status: MediaStatus.failure));
    }
  }

  Future<void> getLikes(int index) async {
    late final List<Doc>? docs = state.media?.baseMedia.docs;
    if (docs == null) return;
    final copyOfDocs = List.of(docs);
    final prevDoc = copyOfDocs[index];
    try {
      final likes = await _mediaRepository.getLikes(prevDoc);
      final newDoc = prevDoc.copyWith(likes: likes);
      copyOfDocs[index] = newDoc;
      final baseMediaCopy = state.media?.baseMedia.copyWith(docs: copyOfDocs);
      final media = state.media?.copyWith(baseMedia: baseMediaCopy);
      emit(state.copyWith(media: media, status: MediaStatus.success));
    } on Exception {
      emit(state.copyWith(status: MediaStatus.failure));
    }
  }

  Future<void> commentMedia(int index, String comment) async {
    late final List<Doc>? docs = state.media?.baseMedia.docs;
    if (docs == null) return;
    final copyOfDocs = List.of(docs);
    final prevDoc = copyOfDocs[index];
    final comments = List.of(prevDoc.comments ?? <Comment>[]);
    try {
      final newComment = await _mediaRepository.createComment(prevDoc, comment);
      comments.add(newComment);
      final newDoc = prevDoc.copyWith(comments: comments);
      copyOfDocs[index] = newDoc;
      final baseMediaCopy = state.media?.baseMedia.copyWith(docs: copyOfDocs);
      final media = state.media?.copyWith(baseMedia: baseMediaCopy);
      emit(state.copyWith(media: media, status: MediaStatus.success));
    } on Exception {
      emit(state.copyWith(status: MediaStatus.failure));
    }
  }

  Future<void> getComments(int index) async {
    final List<Doc>? docs = state.media?.baseMedia.docs;
    if (docs == null) return;
    final copyOfDocs = List.of(docs);
    final prevDoc = copyOfDocs[index];
    try {
      final comments = await _mediaRepository.getComments(prevDoc);
      final newDoc = prevDoc.copyWith(comments: comments);
      copyOfDocs[index] = newDoc;
      final baseMediaCopy = state.media?.baseMedia.copyWith(docs: copyOfDocs);
      final media = state.media?.copyWith(baseMedia: baseMediaCopy);
      emit(state.copyWith(media: media, status: MediaStatus.success));
    } on Exception {
      emit(state.copyWith(status: MediaStatus.failure));
    }
  }

  Future<void> followUser(int index) async {
    late final List<Doc>? docs = state.media?.baseMedia.docs;
    if (docs == null) return;
    final copyOfDocs = List.of(docs);
    final prevDoc = copyOfDocs[index];
    final youFollowThisProfile = !(prevDoc.youFollowThisProfile ?? false);
    try {
      await _mediaRepository.followUser(prevDoc);
      final newDoc = prevDoc.copyWith(
        youFollowThisProfile: youFollowThisProfile,
      );
      copyOfDocs[index] = newDoc;
      final baseMediaCopy = state.media?.baseMedia.copyWith(docs: copyOfDocs);
      final media = state.media?.copyWith(baseMedia: baseMediaCopy);
      emit(state.copyWith(media: media, status: MediaStatus.success));
    } on Exception {
      emit(state.copyWith(status: MediaStatus.failure));
    }
  }
}
