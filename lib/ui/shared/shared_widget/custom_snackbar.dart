import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showCustomSnackBar({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      fontSize: 16.0,
      backgroundColor: Colors.black,
      timeInSecForIosWeb: 1,
      gravity: ToastGravity.BOTTOM);
}
