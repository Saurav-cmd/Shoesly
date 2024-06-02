
import 'dart:convert';
import 'package:shoesly/constants/colors.dart';
import '../constants/enum.dart';
import '../global/custom_dialogue_box.dart';
import '../global/singelton_class.dart';
import 'package:http/http.dart' as http;

import 'model_handler.dart';

class ResponseHandler {
  ResponseHandler._();

  static ResponseHandler getInstance() {
    return Singleton(ResponseHandler, () => ResponseHandler._())
    as ResponseHandler;
  }

  static getResponse({required http.Response response, MH? modelManager}) {
    switch (response.statusCode) {
      case 200:
          return ModelHandler.addDataToModel(
              modelManager: modelManager, response: response);
      case 401:
        CustomDialogues.flutterToastDialogueBox("Authorization Failed",
            color: AppColors.errorColor, textColor: AppColors.primaryColor);
        break;
      case 404:
      /*   DialogueBoxes.flutterToastDialogueBox("Data not found",
            color: AppColors.warningColor, length: Toast.LENGTH_LONG);*/
        break;
      case 500:
      /* DialogueBoxes.flutterToastDialogueBox("Server Error",
            color: AppColors.errorColor, length: Toast.LENGTH_LONG);*/
        break;
      case 501:
      /*      DialogueBoxes.flutterToastDialogueBox("Server Error",
            color: AppColors.errorColor, length: Toast.LENGTH_LONG);*/
        break;
    }
  }

  static postResponse(http.Response response, {MH? modelManager}) {
    var decodeResponse = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
      // DialogueBoxes.dismissLoadingDialog();
        return ModelHandler.addDataToModel(
            modelManager: modelManager,
            response: response,
            decodedResponse: decodeResponse);
      case 201:
        return ModelHandler.addDataToModel(
            modelManager: modelManager,
            response: response,
            decodedResponse: decodeResponse);
      case 401:
        CustomDialogues.flutterToastDialogueBox("Authorization Failed",
            color: AppColors.errorColor, textColor: AppColors.primaryColor);
        break;
      case 404:
        CustomDialogues.flutterToastDialogueBox("Data Not Found",
            color: AppColors.primaryColor, textColor: AppColors.secondaryColor);
        break;
      case 400:
        break;
      case 403:
        break;
      case 405:
        break;
      case 500:
          CustomDialogues.flutterToastDialogueBox(
              "Server Error",
              color: AppColors.primaryColor,
              textColor: AppColors.secondaryColor);
        break;
      case 501:
          CustomDialogues.flutterToastDialogueBox(
              "Server Error",
              color: AppColors.primaryColor,
              textColor: AppColors.secondaryColor);

        break;
    }
  }
}