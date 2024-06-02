import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:shoesly/app_routes/routes_const.dart';
import 'package:shoesly/constants/colors.dart';
import 'package:shoesly/constants/controllers.dart';
import 'package:shoesly/constants/extension.dart';
import 'package:shoesly/constants/images_const.dart';
import 'package:shoesly/global/fade_in_image_widget.dart';
import 'package:shoesly/global/my_app_bar.dart';
import 'package:shoesly/screens/cart_screen/controller/cart_controller.dart';
import 'package:shoesly/screens/cart_screen/model/cart_model.dart';

import '../../../global/bottom_sheet_design.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(CartController());
    cartCtrl.fetchCartData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: MyAppBar(
        automaticLeading: true,
        title: "Cart",
        centerTile: true,
      ),
      bottomNavigationBar: Obx(()=>
        BottomSheetDesign(
            cartBtn: _checkOutBtn(context),
            title: "Grand Total",
            price: cartCtrl.grandTotal.value),
      ),
      body: Obx(
        () => cartCtrl.isFetchingCartData.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (cartCtrl.cartData.value.documents ?? []).isEmpty
                ? const Center(
                    child: Text("Oops nothing in the cart!"),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      cartCtrl.fetchCartData();
                    },
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            (cartCtrl.cartData.value.documents ?? []).length,
                        itemBuilder: (ctx, i) {
                          Document? data =
                              cartCtrl.cartData.value.documents?[i];
                          return Dismissible(
                            key: Key(i.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async{
                              await cartCtrl.deleteCartData(data?.name ?? "");
                              await cartCtrl.fetchCartData();
                            },
                            background: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.04.w(context)),
                              alignment: AlignmentDirectional.centerEnd,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: _cartDesign(context, data ?? Document()),
                          );
                        }),
                  ),
      ),
    ));
  }

  Widget _cartDesign(BuildContext context, Document cartData) {
    return IntrinsicHeight(
      child: ListTile(
          isThreeLine: true,
          leading: IntrinsicHeight(
            child: Container(
              width: 0.2.w(context),
              // height: 0.12.h(context),
              decoration: BoxDecoration(
                color: AppColors.tertiaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.02.w(context)),
                  child: FadedImageWidget(
                    imageUrl: "${cartData.fields?.image?.stringValue}",
                    imagePlaceHolder: ImagesConst.product,
                    imageError: ImagesConst.product,
                  )),
            ),
          ),
          title: Text(
            discoverCtrl.truncateText("${cartData.fields?.title?.stringValue}",
                maxLength: 15),
            style: TextStyle(fontSize: 0.015.toRes(context)),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${cartData.fields?.brandName?.stringValue}, ${cartData.fields?.color?.stringValue} ${cartData.fields?.size?.stringValue}",
                style: TextStyle(
                  fontSize: 0.012.toRes(context),
                  color: AppColors.darkGrey,
                ),
              ),
              Text(
                "\$${cartData.fields?.price?.doubleValue}",
                style: TextStyle(
                  fontSize: 0.013.toRes(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _cartIncreaseAndDecrease(context, "-", cartData),
              SizedBox(width: 0.01.w(context)),
              Text("${cartData.fields?.quantity?.integerValue}"),
              SizedBox(width: 0.01.w(context)),
              _cartIncreaseAndDecrease(context, "+", cartData),
            ],
          )),
    );
  }

  _cartIncreaseAndDecrease(BuildContext context, String info,Document cartData) {
    return GestureDetector(
      onTap: ()async{
        int currentQuantity = int.parse(cartData.fields?.quantity?.integerValue ?? "") ?? 1;
        int newQuantity = (info == "+") ? currentQuantity + 1 : currentQuantity - 1;
        if (newQuantity > 0) {
          await cartCtrl.updateCartData(cartData.name ?? "", newQuantity);
          await cartCtrl.fetchCartData();
        }
      },
      child: Container(
          height: 0.08.h(context),
          width: 0.08.w(context),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.tertiaryColor, width: 2.0),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              info,
              textAlign: TextAlign.center,
            ),
          )),
    );
  }

  Widget _checkOutBtn(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            Get.toNamed(AppRouteConst.orderSummaryScreen);
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
              "CHECK OUT",
              style: TextStyle(
                  fontSize: 0.014.toRes(context),
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600),
            ),
          )),
    );
  }
}
