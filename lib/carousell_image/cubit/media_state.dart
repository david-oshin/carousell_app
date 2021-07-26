part of 'media_cubit.dart';

/// El status que representa el estado que está la [Media] actualmente.
/// 
/// Si el [MediaStatus] es [MediaStatus.success] entonces `media` de
/// [MediaState] no será `null`.
enum MediaStatus { initial, loading, success, failure }

/// Atajos para cuando se pregunte por [MediaStatus] sea menos "verboso"
extension MediaStatusX on MediaStatus {
  bool get isInitial => this == MediaStatus.initial;
  bool get isLoading => this == MediaStatus.loading;
  bool get isSuccess => this == MediaStatus.success;
  bool get isFailure => this == MediaStatus.failure;
}

/// Representa el [status] del [media].
/// 
/// Para más información mira [MediaStatus] y [Media].
class MediaState extends Equatable {
  const MediaState({
    this.status = MediaStatus.initial,
    this.media,
  });

  final MediaStatus status;
  final Media? media;

  MediaState copyWith({
    MediaStatus? status,
    Media? media,
  }) {
    return MediaState(
      status: status ?? this.status,
      media: media ?? this.media,
    );
  }

  @override
  List<Object?> get props => [status, media];
}
