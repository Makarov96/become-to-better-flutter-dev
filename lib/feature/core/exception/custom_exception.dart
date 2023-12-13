import 'package:equatable/equatable.dart';

abstract class CustomException with EquatableMixin implements Exception {
  final String error;
  final String preffix;

  const CustomException({
    required this.error,
    required this.preffix,
  });
  @override
  List<Object?> get props => [error, preffix];
}

class NetworkError extends CustomException {
  NetworkError({
    required super.error,
    required super.preffix,
  });
}
