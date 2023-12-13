import 'package:dartz/dartz.dart';
import 'package:sample_dependecy_inversion/feature/core/exception/custom_exception.dart';

abstract class ProfileRepository {
  Future<Either<CustomException, String>> getMyCustomData();
}
