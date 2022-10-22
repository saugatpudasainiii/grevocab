import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import '../../ui/widgets/flutter_toast.dart';
import '../repositories/signUp_repositories.dart';

class SignUpModel extends ChangeNotifier {
  bool _isSelected = false;
  bool get isSelected => _isSelected;
  Future requestsignUpUser(String email, String name, String password,
      String passwordAgain, context) async {
    final ProgressDialog pr = ProgressDialog(context);
    try {
      pr.show();
      Response response = await SignUpImpl()
          .requiestSignUp(email, name, password, passwordAgain);
      if (response.statusCode == 200 || response.statusCode == 201) {
        showFlutterToast(Colors.green, "User Created Suceffully");
        pr.hide();
        // SignUp signUp = SignUp.fromJson(response.data);
      }
    } catch (error) {
      showFlutterToast(Colors.red, error.toString());
      pr.hide();
    }
  }

//change changeisShowPassword
  void changeisShowPassword(bool value) {
    _isSelected = !_isSelected;
    notifyListeners();
  }
}
