import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_dependecy_inversion/packages/internet_conection/internet_conection.dart';

part 'internet_guard_event.dart';
part 'internet_guard_state.dart';

class InternetGuardBloc extends Bloc<InternetGuardEvent, InternetGuardState> {
  final InternetGuard _internetGuard;
  InternetGuardBloc({required InternetGuard internetGuard})
      : _internetGuard = internetGuard,
        super(InternetGuardInitial()) {
    on<InternetActiveListener>(_activateInternetListener);
    on<InternetDisableListener>(_disableMethod);

    _internetGuard.onListConection.listen(
      (event) {
        add(InternetActiveListener(status: event));
      },
    );
  }

  FutureOr<void> _activateInternetListener(
      InternetActiveListener event, Emitter<InternetGuardState> emit) async {
    if (event.status == InternetConection.connect) {
      resetState(emit: emit);
      emit(InternetGuardWith());
    } else {
      resetState(emit: emit);
      emit(InternetGuardWithout());
    }
  }

  FutureOr<void> _disableMethod(
    InternetDisableListener event,
    Emitter<InternetGuardState> emit,
  ) {
    resetState(emit: emit);
    _internetGuard.dispose();

    emit(InternetGuardDisable());
  }

  void resetState({
    required Emitter<InternetGuardState> emit,
  }) {
    emit(InternetGuardInitial());
  }
}
