import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_repository/media_repository.dart';

export 'package:media_repository/media_repository.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

part 'media_state.dart';

/// Maneja la lógica del recurso [Media] mediante [MediaRepository].
class MediaCubit extends Cubit<MediaState> {
  MediaCubit(this._mediaRepository) : super(MediaState());

  final MediaRepository _mediaRepository;

  /// Busca en el repositorio la [Media] del usuario actual.
  /// 
  /// Usa [state.status] para saber el estado que este tiene y
  /// [state.media] para utilizar la [Media] actual, estará
  /// disponible si [state.status] es [MediaStatus.success].
  Future<void> fetchMedia() async {
    emit(state.copyWith(status: MediaStatus.loading));
    try {
      final media = await _mediaRepository.getMedia();
      emit(state.copyWith(status: MediaStatus.success, media: media));
    } on Exception {
      emit(state.copyWith(status: MediaStatus.failure));
    }
  }
}
