import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:user_repository/user_repository.dart';

import 'models/models.dart';
import 'utils/utils.dart';

/// Maneja todas las peticiones al servidor del recurso [BaseMedia].
///
/// Para retornar la [BaseMedia] del usuario logueado utiliza [get] de la
/// siguiente manera:
///
/// ```dart
/// final repository = MediaRepository();
/// final media = await repository.getMedia(MediaType.images);
/// print(media); // Retorna imágenes
/// ```
///
/// En el caso anterior se retorna la respuesta del servidor parseado a [BaseMedia],
/// en este caso la [BaseMedia] sera tipo [TypeOfMedia.image]. Si quieres video
/// hazlo de la siguiente manera:
///
/// ```dart
/// final repository = MediaRepository();
/// final media = await repository.getMedia(MediaType.video);
/// print(media); // Retorna videos
/// ```
class MediaRepository {
  final http.Client _httpClient;
  final UserRepository _userRepository;

  MediaRepository({
    http.Client? httpClient,
    UserRepository? userRepository,
  })  : _httpClient = httpClient ?? http.Client(),
        _userRepository = UserRepository();

  /// Retorna la [Media] del usuario logueado actualmente.
  Future<Media> get(TypeOfMedia type, {String token = token}) async {
    final response = await _httpClient.post(
      Uri.parse(apiFilteringMedia),
      headers: apiDefaultHeaders(token),
      body: json.encode({
        'timezone_name': timezoneName,
        'type': type.typeToString,
      }),
    );
    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.ok) throw MediaServerError();
    return Media.fromJson(type, response.body);
  }

  /// Crea un like en el [doc.id] que hizo el [doc.userId].
  Future<void> makeLike(Doc doc, {String token = token}) async {
    final user = await _userRepository.authMe();
    final response = await http.post(
      Uri.parse(pathToMakeLike),
      headers: apiDefaultHeaders(token),
      body: json.encode({
        'mediaId': doc.id,
        'clientId': user.id,
      }),
    );
    print(response.body);
    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.created) throw CreatingLikesServerError();
  }

  /// Devuelve la cantidad de likes que tiene un [Doc].
  Future<int> getLikes(Doc doc, {String token = token}) async {
    if (doc.id == null) throw MediaIdIsNull();
    final response = await http.get(
      Uri.parse(pathToGetLikes(doc.id!)),
      headers: apiDefaultHeaders(token),
    );
    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.ok) throw GettingLikesServerError();
    return (json.decode(response.body) as Map<String, dynamic>)['data'] as int;
  }

  /// Devuelve los comentarios que tiene [doc.id].
  Future<List<Comment>> getComments(Doc doc, {String token = token}) async {
    if (doc.id == null) throw MediaIdIsNull();
    final response = await http.get(
      Uri.parse(pathToGetComments(doc.id!)),
      headers: apiDefaultHeaders(token),
    );
    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.ok) throw GettingCommentsServerError();
    final commentsData = json.decode(response.body) as Map<String, dynamic>;
    final comments = <Comment>[];
    (commentsData['data'] as List).forEach((e) {
      comments.add(Comment.fromMap(e));
    });
    return comments;
  }

  /// Devuelve los comentarios que tiene [doc.id].
  Future<Comment> createComment(
    Doc doc,
    String comment, {
    String token = token,
  }) async {
    final user = await _userRepository.authMe();
    final response = await http.post(
      Uri.parse('$servicesURL/$pathToMakeComments'),
      headers: apiDefaultHeaders(token),
      body: json.encode({
        'mediaId': doc.id,
        'clientId': user.id,
        'comment': comment,
      }),
    );
    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.created) throw CreatingCommentsServerError();
    return Comment.fromJson(response.body);
  }

  /// Sigue a [doc.userId].
  Future<void> followUser(Doc doc) async {
    try {
      final ws = await WebSocket.connect(wsFollowUser);
      final user = await _userRepository.authMe();
      if (ws.readyState == WebSocket.open) {
        /// TODO: No asumas que esto no puede ser nulo!
        ws.add(wsAddFollowerJSON(
          doc.youFollowThisProfile!,
          user.id!,
          doc.userId!,
        ));
        final uri = Uri.parse(apiFollowUserEndpoint(user.id!, doc.userId!));
        if (doc.youFollowThisProfile!) {
          await http.delete(uri, headers: apiDefaultHeaders(token));
        } else {
          await http.post(uri, headers: apiDefaultHeaders(token));
        }
      } else {
        throw ConnectionDeniedError();
      }
    } on Exception {
      throw WebSocketError();
    }
  }
}
