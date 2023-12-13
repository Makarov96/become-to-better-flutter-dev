import 'package:get_it/get_it.dart';
import 'package:sample_dependecy_inversion/feature/feature_sl.dart';
import 'package:sample_dependecy_inversion/feature/services/param_through_screen/param_through_screen.dart';
import 'package:sample_dependecy_inversion/feature/services/param_through_screen/params_through_screen_factory.dart';

import 'package:sample_dependecy_inversion/packages/package_sl.dart';

final sl = GetIt.instance;

void setup() async {
  PackageSl.init();
  FeatureSL.init();

  sl.registerLazySingleton<ParamsThroughScreen>(
    () => ParamsThroughScreen(),
  );
  sl.registerFactory<ParamsThroughScreenFactory>(
    () => ParamsThroughScreenFactory(),
  );
}
