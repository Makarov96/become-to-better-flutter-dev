part of 'internet_guard_bloc.dart';

sealed class InternetGuardEvent extends Equatable {
  const InternetGuardEvent();

  @override
  List<Object> get props => [];
}

final class InternetActiveListener extends InternetGuardEvent {
  final InternetConection status;

  const InternetActiveListener({required this.status});

  @override
  List<Object> get props => [status];
}

final class InternetDisableListener extends InternetGuardEvent {}
