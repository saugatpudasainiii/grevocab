import 'package:bookstolook/core/services/requiestHandler.dart';
import 'package:dio/dio.dart';

abstract class SignUpRepo {
  Future<Response> requiestSignUp(
      String email, String name, String password, String passwordAgain);
}

class SignUpImpl extends SignUpRepo {
  @override
  Future<Response> requiestSignUp(
      String email, String name, String password, String passwordAgain) async {
    try {
      final response = await RequestHandler()
          .requestSignUp(email, name, password, passwordAgain);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
