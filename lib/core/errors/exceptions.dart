// ignore_for_file: unused_element

import 'package:supabase/supabase.dart';

import '../utils/constants.dart';

class ServerException implements Exception {
  final String? message;

  ServerException({
    this.message = EXCEPTION_UNKNOWN,
  });

  static ServerException _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        throw ServerException(message: EXCEPTION_UNKNOWN);
      case 404:
        throw ServerException(message: EXCEPTION_NOT_FOUND);
      case 405:
        throw ServerException(message: EXCEPTION_METHOD);
      case 415:
        throw ServerException(message: EXCEPTION_MEDIA_TYPE);
      case 422:
        throw ServerException(message: EXCEPTION_UNKNOWN);
      case 500:
        throw ServerException(message: EXCEPTION_ISE);
      default:
        throw ServerException(message: EXCEPTION_UNKNOWN);
    }
  }
}

class CacheException implements Exception {
  final String? message;

  CacheException({this.message = EXCEPTION_UNKNOWN});
}

class UnknownException implements Exception {
  final String? message;

  UnknownException({this.message});
}

class NotFoundException implements Exception {
  final String? message;

  NotFoundException({this.message});
}

class PostgrestConnectionInvalidUriException extends PostgrestException {
  PostgrestConnectionInvalidUriException({required super.message});
}

class PostgrestConnectionFailedException extends PostgrestException {
  PostgrestConnectionFailedException({required super.message});
}

class PostgrestInvalidAuthorizationTokenException extends PostgrestException {
  PostgrestInvalidAuthorizationTokenException({required super.message});
}

class PostgrestQueryFailedException extends PostgrestException {
  PostgrestQueryFailedException({required super.message});
}

class PostgrestResourceNotFoundException extends PostgrestException {
  PostgrestResourceNotFoundException({required super.message});
}

class PostgrestServerException extends PostgrestException {
  PostgrestServerException({required super.message});
}

class UnknownPostgrestException extends PostgrestException {
  UnknownPostgrestException({required super.message});
}
