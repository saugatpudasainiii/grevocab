import 'package:bookstolook/ui/widgets/progress_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showFlutterToast(Color color, String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showProgressDialogueFs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => CustomProgressDialogFS(),
  );
}
