import 'package:education_app/core/app/errors/exception.dart';
import 'package:education_app/core/common/constant/constants.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(
      {required super.message, super.statusCode = kConnectionStatusCode});

  ConnectionFailure.fromException(ConnectionException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}

class CacheFailure extends Failure {
  const CacheFailure(
      {required super.message, super.statusCode = kCacheStatusCode});

  CacheFailure.fromException(CacheException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
