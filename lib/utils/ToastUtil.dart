import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void show(
      String message, {
        Toast toastLength = Toast.LENGTH_SHORT,
        ToastGravity gravity = ToastGravity.BOTTOM,
        Color? backgroundColor,
        Color? textColor,
        double fontSize = 16.0,
        int timeInSecForIosWeb = 2,
      }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor ?? Colors.black.withOpacity(0.7),
      textColor: textColor ?? Colors.white,
      fontSize: fontSize,
    );
  }

  static void cancel() {
    Fluttertoast.cancel();
  }
}
