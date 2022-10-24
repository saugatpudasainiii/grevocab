import 'package:dio/dio.dart';
import 'apis.dart';
import 'dioHandler.dart';

class RequestHandler {
  Dio dio = ApiProvider().dio;

//to regiister new user
  Future<Response> requestSignUp(
      String email, String name, String password, String passwordAgain) async {
    return await dio.post(
      Apis.signUp,
      data: ({
        "name": name,
        "email": email,
        "password": password,
        "passwordConfirm": passwordAgain
      }),
    );
  }

  //to login user
  Future<Response> registerLogin(String email, String password) async {
    return await dio.post(
      Apis.logIn,
      data: ({
        "email": email,
        "password": password,
      }),
    );
  }

  //get categories
  Future<Response> getCategories() async {
    return await dio.get(
      Apis.getCatogiries,
    );
  }
}
