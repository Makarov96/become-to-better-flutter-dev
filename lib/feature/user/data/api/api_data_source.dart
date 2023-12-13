import 'package:dartz/dartz.dart';
import 'package:sample_dependecy_inversion/feature/core/exception/custom_exception.dart';
import 'package:sample_dependecy_inversion/feature/user/domain/repository/profile_repository.dart';
//import 'package:http/http.dart' as http;

class ApiDataSource extends ProfileRepository {
  @override
  Future<Either<CustomException, String>> getMyCustomData() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      //final response = await http.get(Uri.parse(''));
      //response.statusCode.handlerError();
      return const Right('Return data from backend');
    } catch (e) {
      return Left(
        NetworkError(
          error: e.toString(),
          preffix: e.hashCode.toString(),
        ),
      );
    }
  }
}

extension HttpHandler on int {
  void handlerError() {
    if (this > 200 && this < 300) {
      return;
    } else {
      if (this == 400) {
        throw (NetworkError(error: 'error de red', preffix: '400'));
      }
    }
  }
}
