part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class ProfileInitEvent extends ProfileEvent {
  const ProfileInitEvent();
}

class GetDataFromBackendEvent extends ProfileEvent {
  const GetDataFromBackendEvent();
}
