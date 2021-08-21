import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'models/models.dart';
import 'utils/utils.dart';

/// Maneja todas las peticiones al servidor del recurso [User].
///
/// Para retornar el [User] utiliza [authMe] de la siguiente manera:
///
/// ```dart
/// final repository = UserRepository();
/// final user = await repository.authMe(token);
/// print(media); // Retorna el usuario
/// ```
class UserRepository {
  final http.Client _httpClient;

  UserRepository({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// Retorna la información del [User] basado en el [accessToken].
  Future<User> authMe({String? accessToken = token}) async {
    /// TODO: El token no puede tener un valor predeterminado, esto es para
    /// probar el API.
    /// TODO: Arrojar un [Exception] si es nulo el token si ya el TODO anterior
    /// se completo
    final response = await _httpClient.get(
      Uri.parse(apiAuthMe),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.ok) throw AuthMeError();
    return User.fromJson(response.body);
  }
}
