import 'package:flutter/material.dart';
import 'package:shoesly/constants/extension.dart';
import '../constants/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({super.key,
    this.title,
    this.leading,
    this.widList,
    this.backgroundColor,
    this.statusBarColor = const Color(0xffF6F6F6),
    this.brightness = Brightness.dark,
    this.centerTile = false,
    this.textColor = const Color(0xFFf2f2f2),
    this.appBarHeight = kToolbarHeight,
    this.automaticLeading = false
  }) : preferredSize = Size.fromHeight(appBarHeight);

  final String? title;
  final Widget? leading;
  final List<Widget>? widList;
  final Color? backgroundColor;
  final Brightness? brightness;
  final Color? statusBarColor;
  final bool? centerTile;
  final Color? textColor;
  final double appBarHeight;
  final bool automaticLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      automaticallyImplyLeading: automaticLeading,
      title: Text(
            title ?? "",
            style: TextStyle(
              fontSize: 0.016.toRes(context),
              fontWeight: FontWeight.w500,
              fontFamily: "Roboto",
              color: AppColors.secondaryColor,
            ),
          ),
      leading: leading,
      actions: widList,
      centerTitle: centerTile,
      toolbarHeight: appBarHeight,
    );
  }

  @override
  final Size preferredSize;
}

