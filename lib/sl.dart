import 'package:get_it/get_it.dart';
import 'package:sample_dependecy_inversion/feature/feature_sl.dart';

import 'package:sample_dependecy_inversion/packages/package_sl.dart';

final sl = GetIt.instance;

void setup() async {
  PackageSl.init();
  FeatureSL.init();
}
