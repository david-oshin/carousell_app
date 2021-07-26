part of '../media_repository.dart';

/// Maneja todas las peticiones al servidor del recurso [Media].
///
/// Para retornar la [Media] del usuario logueado utiliza [getMedia] de la
/// siguiente manera:
/// 
/// ```dart
/// final repository = MediaRepository();
/// final media = await repository.getMedia();
/// print(media); // Retorna imagenes
/// ```
/// 
/// En el caso anterior se retorna la respuesta del servidor parseado a [Media],
/// en este caso la [Media] sera tipo [MediaType.image]. Si quieres video hazlo
/// de la siguiente manera:
/// 
/// ```dart
/// final repository = MediaRepository();
/// // 🚨 No se ha probado aún.🚨
/// final media = await repository.getMedia(MediaType.video);
/// print(media); // Retorna videos
/// ```
class MediaRepository {
  /// El endpoint base del API.
  final _urlBaseEnpoint = 'https://api.oshinstar.com';

  /// El path al recurso [Media].
  final _pathToMedia = 'filtering/media';

  /// Retorna la [Media] del usuario logueado actualmente.
  Future<Media> getMedia([MediaType type = MediaType.image]) async {
    final response = await http.post(
      Uri.parse('$_urlBaseEnpoint/$_pathToMedia'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ${_sampleToken()}',
      },
      body: json.encode({
        'timezone_name': _getDefaultTimeZoneName(),
        'type': type.name,
      }),
    );
    if (response.statusCode != HttpStatus.ok) {
      throw Exception(
        'Error while fetching media, status code given is'
        ' ${response.statusCode}, and the body is: ${response.body}',
      );
    }
    return Media.fromJson(response.body);
  }

  /// El token por preterminado.
  ///
  /// NOTA: La app no debe tener "token por preterminado", esto es para
  /// propósito de probar el API.
  String _sampleToken() => 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9'
      '.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhw'
      'IjoxNjI5ODY4MjMyLCJqdGkiOiJlNTZhMmI1Mj'
      'lmN2Q0ODQ3YjFlODMwODhmNmNjZWZmMSIsInVz'
      'ZXJfaWQiOjE4MzYsInRvdHBfZW5hYmxlZCI6ZmF'
      'sc2V9.9ua_IbmhQVDBQ4g1R4z9SWPiXdf7EFKlkB0ckzDf_TE';

  /// La localización por preterminado.
  ///
  /// NOTA: La app no debe tener "localización por preterminado", esto es para
  /// propósito de probar el API.
  String _getDefaultTimeZoneName() => 'America/Santo_Domingo';
}
