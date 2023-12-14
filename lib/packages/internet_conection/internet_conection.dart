import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

enum InternetConection {
  connect,
  disconnect,
}

typedef CheckerInterner = Function(bool);

abstract class InternetGuard {
  Future<bool> get hasConnection;
  Stream<InternetConection> get onListConection;
  void call({required CheckerInterner checker});

  void dispose();
}

class InternetGuardImpl extends InternetGuard {
  final StreamController<InternetConection> _getStatus =
      StreamController<InternetConection>();

  StreamSubscription<InternetConnectionStatus>? _listener;
  @override
  Future<bool> get hasConnection async =>
      await InternetConnectionChecker().hasConnection;

  @override
  Stream<InternetConection> get onListConection {
    InternetConnectionChecker().onStatusChange.forEach(
      (event) {
        if (event == InternetConnectionStatus.connected) {
          _getStatus.add(InternetConection.connect);
        } else {
          _getStatus.add(InternetConection.disconnect);
        }
      },
    );

    return _getStatus.stream;
  }

  @override
  void call({required CheckerInterner checker}) async {
    if (await (hasConnection)) {
      checker(true);
    } else {
      checker(false);
    }
  }

  @override
  void dispose() async {
    _listener?.cancel();
    _listener = null;
    _getStatus.sink.close();
  }
}
