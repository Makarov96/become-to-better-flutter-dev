part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {
  const ProfileState({this.userName = ''});
  final String userName;
  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  const ProfileSuccess({
    super.userName,
  });

  @override
  List<Object> get props => [userName];
}

final class ProfileError extends ProfileState {
  const ProfileError({
    required this.message,
    required this.peffix,
  });
  final String message;
  final String peffix;

  @override
  List<Object> get props => [message, peffix];
}

extension UserHandlingState on ProfileState {
  bool get isSuccessState => this is ProfileSuccess;
  String get userProfile {
    if (this is ProfileSuccess) {
      final state = (this as ProfileSuccess);
      return state.userName;
    } else {
      return '';
    }
  }
}
