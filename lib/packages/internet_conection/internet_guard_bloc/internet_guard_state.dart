part of 'internet_guard_bloc.dart';

sealed class InternetGuardState extends Equatable {
  const InternetGuardState();

  @override
  List<Object> get props => [];
}

final class InternetGuardInitial extends InternetGuardState {}

final class InternetGuardWith extends InternetGuardState {}

final class InternetGuardWithout extends InternetGuardState {}

final class InternetGuardDisable extends InternetGuardState {}
