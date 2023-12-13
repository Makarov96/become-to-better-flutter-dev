import 'package:sample_dependecy_inversion/feature/user/data/api/api_data_source.dart';
import 'package:sample_dependecy_inversion/feature/user/domain/repository/profile_repository.dart';
import 'package:sample_dependecy_inversion/feature/user/presenter/bloc/bloc/profile_bloc.dart';
import 'package:sample_dependecy_inversion/sl.dart';

class SLUser {
  static init() {
    sl.registerLazySingleton<ProfileRepository>(
      () => ApiDataSource(),
    );
    sl.registerFactory<ProfileBloc>(
      () => ProfileBloc(repository: sl()),
    );
  }
}
