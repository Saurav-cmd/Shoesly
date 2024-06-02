import 'package:flutter/material.dart';
import 'package:shoesly/constants/extension.dart';

import '../constants/colors.dart';

class BottomSheetDesign extends StatelessWidget {
  const BottomSheetDesign ({super.key, required this.cartBtn, required this.title, required this.price});
  final Widget cartBtn;
  final String title;
  final double price;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        color: AppColors.primaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: TextStyle(fontSize: 0.012.toRes(context)),),
                  Text(
                    "\$$price",
                    style: TextStyle(
                        fontSize: 0.016.toRes(context),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              cartBtn,
            ],
          ),
        ),
      ),
    );
  }
}
