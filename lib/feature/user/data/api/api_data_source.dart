import 'package:sample_dependecy_inversion/feature/user/domain/repository/profile_repository.dart';

class ApiDataSource extends ProfileRepository {
  @override
  Future<String> getMyCustomData() async {
    await Future.delayed(const Duration(seconds: 3));
    return '';
  }
}
