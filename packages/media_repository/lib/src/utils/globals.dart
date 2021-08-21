part of 'utils.dart';

/// El path para obtener recurso media.
const apiFilteringMedia = '$apiURL/filtering/media';

/// El path para hacer likes.
const pathToMakeLike = '$servicesURL/interactions/like';

/// El path para hacer comments.
const pathToMakeComments = 'interactions/comment';

Map<String, String> apiDefaultHeaders(String token) => {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

/// El path para obtener likes de un [Media] mediante el [Media.id].
String pathToGetLikes(int mediaID) => '$servicesURL/media/$mediaID/likes';

/// El path para obtener likes de un [Media] mediante el [Media.id].
String pathToGetComments(int mediaID) => '$servicesURL/media/$mediaID/comments';

/// La localización por preterminado.
///
/// NOTA: La app no debe tener "localización por preterminado", esto es para
/// propósito de probar el API.
const timezoneName = 'America/Santo_Domingo';

/// El token por preterminado.
///
/// NOTA: La app **no** debe tener "token por preterminado", esto es para
/// propósito de probar el API.
const token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjMyMDk4ODU2LCJqdGkiOiIyYWUyZTczODYzZmY0NDk2OTc3M2M2Y2RlYjQ3ZmI2NiIsInVzZXJfaWQiOjE4MDUsInRvdHBfZW5hYmxlZCI6ZmFsc2V9.SV0XxQ6PZ85hNVFWaT3279NVlztSqJS4_UaNUPcEvSo';

/// El endpoint base del API.
const apiURL = 'https://api.oshinstar.com';

/// El endpoint base del API de Jose.
const servicesURL = 'https://services.oshinstar.com';

/// El endpoint web sockets.
const wsServicesURL = 'ws://wss.oshinstar.com';

/// El path para seguir a un usuario.
const wsFollowUser = '$wsServicesURL/interactions/user/follow';

String wsAddFollowerJSON(
  bool youFollowThisProfile,
  int clientId,
  int targetId,
) =>
    json.encode({
      "transactionType": youFollowThisProfile ? "user_follow" : "user_unfollow",
      "clientId": clientId,
      "targetId": targetId,
    });

String apiFollowUserEndpoint(int clientID, int targetID) =>
    '$apiURL/popularity/user/$clientID/follow/$targetID';

// $servicesURL/detailed/id
