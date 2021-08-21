part of 'utils.dart';

/// Representa los argumentos que se le pasa a una pantalla.
///
/// Usa [data] para representar los argumentos a pasar a otra pantalla.
/// ```dart
/// final args = settings.arguments as ScreenArguments;
/// /// `settings` es una instancia de [RouteSettings].
/// final value = arguments.data['key'];
/// ```
class ScreenArguments {
  /// Se usa para acceder a los distintos campos.
  final Map<String, dynamic> data;

  const ScreenArguments({required this.data});
}
