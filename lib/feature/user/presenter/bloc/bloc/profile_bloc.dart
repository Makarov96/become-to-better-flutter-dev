import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_dependecy_inversion/feature/core/exception/custom_exception.dart';
import 'package:sample_dependecy_inversion/feature/user/domain/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;
  ProfileBloc({
    required ProfileRepository repository,
  })  : _repository = repository,
        super(ProfileInitial()) {
    on<ProfileInitEvent>(_eventProfile);
    on<GetDataFromBackendEvent>(_getDataFromBackend);
  }

  FutureOr<void> _getDataFromBackend(
      GetDataFromBackendEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileFBLoading());

    final either = await _repository.getMyCustomData();
    either.fold((l) => emit(ProfileError(customException: l)),
        (r) => emit(ProfileFBSuccess(userFBName: r)));
  }

  FutureOr<void> _eventProfile(
      ProfileInitEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());
      final request = await Future.delayed(
        const Duration(seconds: 3),
      );

      emit(
        ProfileSuccess(userName: request.runtimeType.toString()),
      );
    } catch (e) {
      emit(
        ProfileError(
            customException: NetworkError(
                error: 'Error when try to call to backend', preffix: '433')),
      );
    }
  }
}
