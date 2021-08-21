part of 'utils.dart';

/// El endpoint para autenticar un usuario.
const apiAuthMe = '$_apiURL/auth/me';

/// La url del api.
const _apiURL = 'https://api.oshinstar.com';

/// Un token de prueba.
///
/// NOTA: La app **no** debe tener token por preterminado, esto es para
/// propósito de probar el [_apiURL].
const token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjMyMDk4ODU2LCJqdGkiOiIyYWUyZTczODYzZmY0NDk2OTc3M2M2Y2RlYjQ3ZmI2NiIsInVzZXJfaWQiOjE4MDUsInRvdHBfZW5hYmxlZCI6ZmFsc2V9.SV0XxQ6PZ85hNVFWaT3279NVlztSqJS4_UaNUPcEvSo';
