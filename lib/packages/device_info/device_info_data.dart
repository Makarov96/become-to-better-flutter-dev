import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

abstract class DeviceInfoData {
  Future<String> get versionName;
}

class DeviceInfoImpl extends DeviceInfoData {
  DeviceInfoImpl({
    required DeviceInfoPlugin deviceInfo,
  }) : _deviceInfo = deviceInfo;
  final DeviceInfoPlugin _deviceInfo;

  @override
  Future<String> get versionName async => Platform.isIOS
      ? (await _deviceInfo.iosInfo).name
      : (await _deviceInfo.androidInfo).device;
}
