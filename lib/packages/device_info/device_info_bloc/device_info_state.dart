part of 'device_info_bloc.dart';

sealed class DeviceInfoState extends Equatable {
  const DeviceInfoState();

  @override
  List<Object> get props => [];
}

final class DeviceInfoInitial extends DeviceInfoState {}

final class DeviceInfoSuccess extends DeviceInfoState {
  const DeviceInfoSuccess({required this.deviceName});
  final String deviceName;

  @override
  List<Object> get props => [deviceName];
}

final class DeviceInfoLoading extends DeviceInfoState {}

final class DeviceInfoError extends DeviceInfoState {}
