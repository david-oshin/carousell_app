part of 'models.dart';

/// {@template oshin_type_of_media}
/// Los tipos de [BaseMedia] que pueden haber.
/// {@endtemplate}
enum TypeOfMedia { image, video, audio }

/// Métodos que se pueden ejecutar sobre el [TypeOfMedia].
extension TypeOfMediaMethods on TypeOfMedia {
  bool get isAudio => this == TypeOfMedia.audio;

  bool get isImage => this == TypeOfMedia.image;

  bool get isVideo => this == TypeOfMedia.video;

  /// Retorna el [TypeOfMedia] elegido como un `String`.
  ///
  /// ```dart
  /// final type = TypeOfMedia.image;
  /// print(type.name); // Imprime "image";
  /// ```
  String get typeToString => this.toString().split('.')[1];
}
