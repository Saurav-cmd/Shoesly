
import 'package:flutter/material.dart';
import '../global/singelton_class.dart';

class AppColors {
  AppColors._();

  static AppColors getInstance() {
    return Singleton(AppColors, () => AppColors._()) as AppColors;
  }

  static const primaryColor = Color(0xFFFFFFFF);
  static const secondaryColor = Color(0xFF101010);
  static const tertiaryColor = Color(0xFFF3F3F3);
  static const darkGrey = Color(0xFF666666);

  static const errorColor = Colors.red;
  static const warningColor = Colors.orange;
  static const successColor = Colors.green;
}