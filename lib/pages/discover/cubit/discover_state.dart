part of 'discover_cubit.dart';

/// El status que representa el estado que está la [TypeOfMedia] actualmente.
///
/// Si el [MediaStatus] es [MediaStatus.success] entonces `media` de
/// [DiscoverState] no será `null`.
enum MediaStatus { initial, loading, success, failure }

/// Atajos para cuando se pregunte por [MediaStatus] sea menos "verboso"
extension MediaStatusX on MediaStatus {
  bool get isInitial => this == MediaStatus.initial;
  bool get isLoading => this == MediaStatus.loading;
  bool get isSuccess => this == MediaStatus.success;
  bool get isFailure => this == MediaStatus.failure;
}

/// El estado del Carousel.
class DiscoverState extends Equatable {
  const DiscoverState({
    this.media,
    this.status = MediaStatus.initial,
  });

  final Media? media;
  final MediaStatus status;

  DiscoverState copyWith({
    Media? media,
    MediaStatus? status,
  }) =>
      DiscoverState(
        media: media ?? this.media,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        media,
        status,
      ];
}
