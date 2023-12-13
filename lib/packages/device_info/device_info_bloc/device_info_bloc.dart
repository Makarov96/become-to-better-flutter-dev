import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_dependecy_inversion/packages/device_info/device_info_data.dart';

part 'device_info_event.dart';
part 'device_info_state.dart';

class DeviceInfoBloc extends Bloc<DeviceInfoEvent, DeviceInfoState> {
  final DeviceInfoData _deviceInfoData;
  DeviceInfoBloc({required DeviceInfoData deviceInfoData})
      : _deviceInfoData = deviceInfoData,
        super(DeviceInfoInitial()) {
    on<DeviceInfoCall>(_deviceInfoEvent);
  }

  FutureOr<void> _deviceInfoEvent(
    DeviceInfoCall event,
    Emitter<DeviceInfoState> emit,
  ) async {
    try {
      emit(DeviceInfoLoading());

      final deviceName = await _deviceInfoData.versionName;

      emit(
        DeviceInfoSuccess(deviceName: deviceName),
      );
    } catch (e) {
      emit(
        DeviceInfoError(),
      );
    }
  }
}
