import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../constants/colors.dart';
import '../global/custom_dialogue_box.dart';
import '../global/singelton_class.dart';


class ApiUtils {
  ApiUtils._();

  static ApiUtils getInstance() {
    return Singleton(ApiUtils, () => ApiUtils._()) as ApiUtils;
  }

  static Future<http.Response> getResponse(String url,
      {Map<String, String>? headers}) async {
    try {
      return await http.get(Uri.parse(url), headers: headers).timeout(
          const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      CustomDialogues.flutterToastDialogueBox(
          "Timeout please try again!", color: AppColors.errorColor,
          textColor: AppColors.primaryColor);
      rethrow;
    } on SocketException catch (_) {
      CustomDialogues.flutterToastDialogueBox(
          "Please check you internet!", color: AppColors.errorColor,
          textColor: AppColors.primaryColor);
      rethrow;
    }
    catch (e) {
      CustomDialogues.flutterToastDialogueBox(
          "Error Occurred !", color: AppColors.errorColor,
          textColor: AppColors.primaryColor);
      rethrow;
    }
  }

  static Future<http.Response> postResponse(String url,
      {Map<String, String>? header, Map<String, dynamic>? body}) async {
    try {
      String encodedBody = jsonEncode(body);
      log("This is encodedBody: ${encodedBody}");
      return await http.post(Uri.parse(url), headers: header, body: encodedBody)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      CustomDialogues.flutterToastDialogueBox(
          "Timeout please try again!", color: AppColors.errorColor,
          textColor: AppColors.primaryColor);
      rethrow;
    } on SocketException catch (_) {
      CustomDialogues.flutterToastDialogueBox(
          "Please check you internet!", color: AppColors.errorColor,
          textColor: AppColors.primaryColor);
      rethrow;
    }
    catch (e) {
      CustomDialogues.flutterToastDialogueBox(
          "Error Occurred !", color: AppColors.errorColor,
          textColor: AppColors.primaryColor);
      rethrow;
    }
  }

  static Future<http.Response> postResponseWithoutHeader(String url,
      {Map<String, dynamic>? body}) async {
    try {
      return await http.post(Uri.parse(url), body: body).timeout(
          const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      CustomDialogues.flutterToastDialogueBox(
          "Timeout please try again!", color: AppColors.errorColor,
          textColor: AppColors.primaryColor);
      rethrow;
    } on SocketException catch (_) {
      CustomDialogues.flutterToastDialogueBox(
          "Please check you internet!", color: AppColors.errorColor,
          textColor: AppColors.primaryColor);
      rethrow;
    }
    catch (e) {
      CustomDialogues.flutterToastDialogueBox(
          "Error Occurred !", color: AppColors.errorColor,
          textColor: AppColors.primaryColor);
      rethrow;
    }
  }

  static Future<http.MultipartRequest> postMultipartData(String url,
      {Map<String, dynamic>? body}) async {
    try {
      return http.MultipartRequest("POST", Uri.parse(url));
    } on TimeoutException catch (_) {
      CustomDialogues.flutterToastDialogueBox(
          "Timeout please try again!", color: AppColors.errorColor,
          textColor: AppColors.primaryColor);
      rethrow;
    } on SocketException catch (_) {
      CustomDialogues.flutterToastDialogueBox(
          "Please check you internet!", color: AppColors.errorColor,
          textColor: AppColors.primaryColor);
      rethrow;
    }
    catch (e) {
      CustomDialogues.flutterToastDialogueBox(
          "Error Occurred !", color: AppColors.errorColor,
          textColor: AppColors.primaryColor);
      rethrow;
    }
  }
}