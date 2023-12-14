import 'package:device_info_plus/device_info_plus.dart';
import 'package:sample_dependecy_inversion/packages/device_info/device_info_bloc/device_info_bloc.dart';
import 'package:sample_dependecy_inversion/packages/device_info/device_info_data.dart';
import 'package:sample_dependecy_inversion/packages/internet_conection/internet_conection.dart';
import 'package:sample_dependecy_inversion/packages/internet_conection/internet_guard_bloc/internet_guard_bloc.dart';
import 'package:sample_dependecy_inversion/sl.dart';

class PackageSl {
  static init() async {
    sl.registerLazySingleton<DeviceInfoPlugin>(
      () => DeviceInfoPlugin(),
    );

    sl.registerFactory<DeviceInfoData>(
      () => DeviceInfoImpl(
        deviceInfo: sl(),
      ),
    );

    sl.registerLazySingleton<DeviceInfoBloc>(
      () => DeviceInfoBloc(
        deviceInfoData: sl(),
      ),
    );

    sl.registerLazySingleton<InternetGuard>(
      () => InternetGuardImpl(),
    );

    sl.registerLazySingleton<InternetGuardBloc>(
      () => InternetGuardBloc(
        internetGuard: sl(),
      ),
    );
  }
}
