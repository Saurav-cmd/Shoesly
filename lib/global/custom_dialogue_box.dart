

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoesly/global/singelton_class.dart';

class CustomDialogues {
  CustomDialogues._();

  static CustomDialogues getInstance() {
    return Singleton(CustomDialogues, () => CustomDialogues._())
    as CustomDialogues;
  }

  static flutterToastDialogueBox(String message,
      {Color color = Colors.white,
        ToastGravity gravity = ToastGravity.BOTTOM,
        Color textColor = Colors.black,
        Toast length = Toast.LENGTH_SHORT}) {
    return Fluttertoast.showToast(
        msg: message,
        backgroundColor: color,
        toastLength: length,
        textColor: textColor,
        gravity: gravity);
  }
}