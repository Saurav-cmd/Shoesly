import 'package:flutter/material.dart';
import 'package:shoesly/constants/colors.dart';
import 'package:shoesly/constants/extension.dart';
import 'package:shoesly/global/my_app_bar.dart';

import '../../constants/controllers.dart';
import '../../global/bottom_sheet_design.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: MyAppBar(
        automaticLeading: true,
        title: "Order Summary",
        centerTile: true,
      ),
      bottomNavigationBar: BottomSheetDesign(
          cartBtn: _paymentBtn(context), title: "Grand Total", price: cartCtrl.grandTotal.value+20),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerTextDesign(context, "Information"),
            _infoAndOrderDesign(
                context,
                "Payment Method",
                "Credit Card",
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_outlined))),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
              child: const Divider(
                thickness: 1.0,
                color: AppColors.tertiaryColor,
              ),
            ),
            _infoAndOrderDesign(
                context,
                "Location",
                "Canada, Ontario",
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_outlined))),
            _headerTextDesign(context, "Order Detail"),
            Column(
              children: cartCtrl.cartData.value.documents?.map((doc) {
                return _infoAndOrderDesign(
                  context,
                  doc.fields?.title?.stringValue ?? "",
                  "${doc.fields?.brandName?.stringValue}, ${doc.fields?.color?.stringValue} ${doc.fields?.size?.stringValue} Qty ${doc.fields?.quantity?.integerValue}",
                  Text(
                    "\$${double.parse(doc.fields?.price?.doubleValue.toString() ?? "") * int.parse(doc.fields?.quantity?.integerValue ?? "")}",
                    style: TextStyle(
                      fontSize: 0.014.toRes(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList() ?? [],
            ),
            _headerTextDesign(context, "Payment Detail"),
            SizedBox(
              height: 0.02.h(context),
            ),
            _paymentDetailDesign(context, "Sub Total", cartCtrl.grandTotal.value),
            SizedBox(
              height: 0.01.h(context),
            ),
            _paymentDetailDesign(context, "Shipping", 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
              child: const Divider(
                thickness: 1.0,
                color: AppColors.tertiaryColor,
              ),
            ),
            _paymentDetailDesign(context, "Total Order", cartCtrl.grandTotal.value+20,
                fontSize: 0.016.toRes(context), fontWeight: FontWeight.bold),
          ],
        ),
      ),
    ));
  }

  Widget _infoAndOrderDesign(BuildContext context, String title,
      String subtitle, Widget tileTrailing) {
    return ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontSize: 0.014.toRes(context), fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
              fontSize: 0.014.toRes(context), color: AppColors.darkGrey),
        ),
        trailing: tileTrailing);
  }

  Widget _headerTextDesign(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(
          left: 0.04.w(context), right: 0.04.w(context), top: 0.02.h(context)),
      child: Text(title,
          style: TextStyle(
              fontSize: 0.016.toRes(context), fontWeight: FontWeight.bold)),
    );
  }

  Widget _paymentDetailDesign(BuildContext context, String title, double price,
      {double? fontSize, FontWeight? fontWeight}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 0.014.toRes(context), color: AppColors.darkGrey),
          ),
          Text(
            "\$$price",
            style: TextStyle(
                fontSize: fontSize ?? 0.015.toRes(context),
                fontWeight: fontWeight ?? FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _paymentBtn(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
          },
          style: ButtonStyle(
            elevation: WidgetStateProperty.all<double>(0.0),
            backgroundColor:
            WidgetStateProperty.all<Color>(AppColors.secondaryColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 0.02.w(context), vertical: 0.005.h(context)),
            child: Text(
              "PAYMENT",
              style: TextStyle(
                  fontSize: 0.014.toRes(context),
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600),
            ),
          )),
    );
  }
}
