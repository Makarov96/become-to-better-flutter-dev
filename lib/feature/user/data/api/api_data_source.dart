import 'package:dartz/dartz.dart';
import 'package:sample_dependecy_inversion/feature/core/exception/custom_exception.dart';
import 'package:sample_dependecy_inversion/feature/user/domain/repository/profile_repository.dart';
import 'package:sample_dependecy_inversion/packages/internet_conection/internet_conection.dart';
//import 'package:http/http.dart' as http;

class ApiDataSource extends ProfileRepository {
  ApiDataSource({required InternetGuard internetGuard})
      : _internetGuard = internetGuard;

  final InternetGuard _internetGuard;
  @override
  Future<Either<CustomException, String>> getMyCustomData() async {
    final isConnected = await _internetGuard.hasConnection;
    try {
      await Future.delayed(const Duration(seconds: 3));
      //final response = await http.get(Uri.parse(''));
      //response.statusCode.handlerError();

      if (isConnected) {
        //save in local data base
        return const Right('Return data from backend');
      } else {
        // get from local data base
        return const Right('Return data from local data base');
      }
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
