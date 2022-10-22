import 'package:bookstolook/core/services/requiestHandler.dart';
import 'package:dio/dio.dart';

abstract class SignInRepo {
  Future<Response> requestSignIn(String email, String password);
}

class SignInImpl extends SignInRepo {
  @override
  Future<Response> requestSignIn(
    String email,
    String password,
  ) async {
    try {
      final response = await RequestHandler().registerLogin(email, password);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
