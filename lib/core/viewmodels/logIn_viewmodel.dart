import 'package:bookstolook/core/repositories/logIn_repositories.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import '../../ui/views/navigation.dart';
import '../../ui/widgets/flutter_toast.dart';

class LogInModel {
  bool _isSelected = false;
  bool get isSelected => _isSelected;
  Future requestLoginUser(String email, String password, context) async {
    final ProgressDialog pr = ProgressDialog(context);
    try {
      pr.show();
      Response response = await SignInImpl().requestSignIn(email, password);
      if (response.statusCode == 200 || response.statusCode == 201) {
        pr.hide();
        showFlutterToast(Colors.green, "User Login Suceffully");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );

        // SignUp signUp = SignUp.fromJson(response.data);
      }
    } catch (error) {
      showFlutterToast(Colors.red, error.toString());
      pr.hide();
    }
  }
}
//change changeisShowPassword
 