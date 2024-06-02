
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoesly/constants/colors.dart';
import 'package:shoesly/global/custom_dialogue_box.dart';

class ErrorHandler {
  static void handleError(dynamic e) {
    if (e is FirebaseException) {
      CustomDialogues.flutterToastDialogueBox(
          "Error Occurred", color: AppColors.errorColor,
          textColor: AppColors.primaryColor);
      log("Error: ${e.toString()}");
    } else if (e is TimeoutException) {
      CustomDialogues.flutterToastDialogueBox(
          "Time out please check your internet", color: AppColors.errorColor,
          textColor: AppColors.primaryColor, length: Toast.LENGTH_LONG);
      log("Error: ${e.toString()}");
    } else if (e is SocketException) {
      CustomDialogues.flutterToastDialogueBox(
          "Time out please check your internet", color: AppColors.errorColor,
          textColor: AppColors.primaryColor, length: Toast.LENGTH_LONG);
      log("Error: ${e.toString()}");
    } else {
      CustomDialogues.flutterToastDialogueBox(
          "Error Occurred try again later!", color: AppColors.errorColor,
          textColor: AppColors.primaryColor, length: Toast.LENGTH_LONG);
      log("Error: ${e.toString()}");
    }
  }
}
