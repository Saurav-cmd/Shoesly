import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoesly/app_routes/routes_const.dart';
import 'package:shoesly/constants/colors.dart';
import 'package:shoesly/constants/controllers.dart';
import 'package:shoesly/constants/extension.dart';
import 'package:shoesly/global/bottom_sheet_design.dart';
import 'package:shoesly/global/custom_dialogue_box.dart';
import 'package:shoesly/global/my_app_bar.dart';
import 'package:shoesly/screens/discover_screen/models/combined_model.dart';
import 'package:shoesly/screens/discover_screen/widget/reviews_design.dart';

import '../../../constants/images_const.dart';
import '../../../global/rating_builder.dart';

class DiscoverDetailScreen extends StatefulWidget {
  const DiscoverDetailScreen({super.key});

  @override
  State<DiscoverDetailScreen> createState() => _DiscoverDetailScreenState();
}

class _DiscoverDetailScreenState extends State<DiscoverDetailScreen> {
  final CombinedModel cPData = Get.arguments;
  RxInt currentIndex = 0.obs;
  bool isBottomSheetOpen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    discoverCtrl.fetchUsers();
    discoverCtrl.fetchReviews(cPData.productId?.split("products/")[1] ?? "");
    getColorNameAndHexCode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    discoverCtrl.selectedSize.value = -1.0;
    isBottomSheetOpen = false;
    discoverCtrl.selectedImageHex.value = "";
    discoverCtrl.selectedImageColor.value = "";
    discoverCtrl.averageRating.value = 0.0;
  }

  getColorNameAndHexCode() {
    for (ProductImages data in cPData.pImages ?? []) {
      discoverCtrl.selectedImageColor.value = data.colorName ?? "";
      discoverCtrl.selectedImageHex.value = data.colorHex ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    List allImages = (cPData.pImages ?? [])
        .expand((e) => e.images ?? [])
        .toList();

    // Store the first image in a variable
    discoverCtrl.selectedImage.value = allImages.isNotEmpty ? allImages[0] : '';
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.primaryColor,
            appBar: MyAppBar(
              automaticLeading: true,
              widList: [
                IconButton(
                    onPressed: () {
                      Get.toNamed(AppRouteConst.cartScreen);
                    },
                    icon: Image.asset(ImagesConst.bag))
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _productDetail(context),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
                    child: Obx(
                          () => discoverCtrl.isFetchingUserAndReview.isTrue?const Text("Loading..."):
                          Text(
                            "Review (${discoverCtrl.customReviewData.length})",
                            style: TextStyle(
                                fontSize: 0.014.toRes(context),
                                fontWeight: FontWeight.w600),
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 0.01.h(context),
                  ),
                  Obx(() =>
                  discoverCtrl.isFetchingUserAndReview.isTrue
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : discoverCtrl.customReviewData.isEmpty
                      ? const Center(
                    child: Text("No reviews to show!"),
                  )
                      : _reviews(context)),
                  SizedBox(
                    height: 0.03.h(context),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomSheetDesign(
                cartBtn: _addToCartBtn(context),
                title: "Price",
                price: cPData.productPrice ?? 0.0)));
  }

  Widget _productDetail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 0.04.w(context), vertical: 0.02.h(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 0.5.h(context),
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.tertiaryColor,
                borderRadius: BorderRadius.circular(10.0)),
            child: Stack(children: [
              Align(alignment: Alignment.center, child: _imageSlider(context)),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 0.04.h(context),
                  left: 0.04.w(context),
                  top: 0.04.h(context),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Obx(() {
                    final imageUrls = (cPData.pImages ?? [])
                        .expand((e) => e.images ?? [])
                        .toList();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int i = 0; i < (imageUrls.length > 3 ? 3 : imageUrls.length); i++)
                          Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: discoverCtrl.carousalSliderIndex.value == i
                                  ? AppColors.secondaryColor
                                  : AppColors.darkGrey,
                            ),
                          ),
                        if (imageUrls.length > 3)
                          SizedBox()
                      ],
                    );
                  }),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IntrinsicWidth(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 0.02.h(context),
                        right: 0.04.w(context),
                        top: 0.04.h(context)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.04.w(context),
                            vertical: 0.02.h(context)),
                        child: Row(
                          children: [
                            for(ProductImages data in cPData.pImages ?? [])
                             Padding(
                               padding: EdgeInsets.symmetric(horizontal: 0.01.w(context)),
                               child: _colorPickerDesign(data.colorHex ?? ""),
                             )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: 0.04.h(context)),
          Text(
            "${cPData.productName}",
            style: TextStyle(
                fontSize: 0.016.toRes(context),
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor),
          ),
          SizedBox(height: 0.01.h(context)),
          Row(
            children: [
              Obx(() =>discoverCtrl.isFetchingUserAndReview.isTrue?const Text("Loading..."):
                  RatingBuilder(
                    rating: discoverCtrl.averageRating.value,
                  )),
              SizedBox(width: 0.009.w(context)),
              Obx(
                    () =>discoverCtrl.isFetchingUserAndReview.isTrue?const Text("Loading..."):
                    Text(
                      "${discoverCtrl.averageRating}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.012.toRes(context)),
                    ),
              ),
              SizedBox(width: 0.009.w(context)),
              Obx(
                    () =>discoverCtrl.isFetchingUserAndReview.isTrue?const Text("Loading..."):
                    Text(
                      "(${discoverCtrl.customReviewData.length} Reviews)",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 0.012.toRes(context)),
                    ),
              ),
            ],
          ),
          SizedBox(height: 0.02.h(context)),
          Text(
            "Size",
            style: TextStyle(
                fontSize: 0.014.toRes(context), fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: (cPData.shoeSizes ?? [])
                .map((size) =>
                Obx(() => _sizeContainer(context, double.parse(size))))
                .toList(),
          ),
          SizedBox(height: 0.02.h(context)),
          Text(
            "Description",
            style: TextStyle(
                fontSize: 0.014.toRes(context), fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 0.01.h(context)),
          Text(
            "${cPData.productDescription}",
            style: TextStyle(
                fontSize: 0.012.toRes(context), fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _imageSlider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 0.01.h(context), left: 0.04.w(context), right: 0.04.w(context)),
      child: Obx(() => networkCtrl.connectionType.value == 0
          ? Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
        child: _imageSliderNoInternetOrNoImage(),
      )
          : (cPData.pImages ?? []).isEmpty
          ? Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
        child: _imageSliderNoInternetOrNoImage(),
      )
          : SizedBox(
        height: 0.22.h(context),
        width: double.infinity,
        child: CarouselSlider(
          items: (cPData.pImages ?? [])
              .expand((e) => e.images ?? [])
              .where((imageUrl) {
            String colorHex = (cPData.pImages ?? []).firstWhere(
                  (element) => element.images?.contains(imageUrl) ?? false,
            ).colorHex ?? "";

            return colorHex == discoverCtrl.selectedImageHex.value;
          })
              .map((imageUrl) {
            return Image.network(
              imageUrl,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  ImagesConst.noImage,
                  fit: BoxFit.contain,
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              discoverCtrl.updateImageIndex(index);
            },
            autoPlay: false,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
          ),
        )

      )),
    );
  }

  Widget _imageSliderNoInternetOrNoImage() {
    return Container(
      height: 0.22.h(context),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: AppColors.tertiaryColor),
      ),
      child: Center(
          child: Image.asset(
            ImagesConst.product,
            fit: BoxFit.contain,
          )),
    );
  }

  Widget _sizeContainer(BuildContext context, double number) {
    bool isSelected = discoverCtrl.selectedSize.value ==
        number; // Check if this size is selected
    return GestureDetector(
      onTap: () {
        discoverCtrl.selectedSize.value = number; // Update selected size on tap
      },
      child: Container(
          height: 0.1.h(context),
          width: 0.1.w(context),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: isSelected
                    ? AppColors.secondaryColor
                    : AppColors.tertiaryColor,
                width: 2.0),
            color: isSelected ? AppColors.secondaryColor : Colors.transparent,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "$number",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.secondaryColor),
            ),
          )),
    );
  }

  Widget _reviews(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...discoverCtrl.customReviewData.map((review) =>
            ReviewsDesign(
              reviewData: review,
            )),
        _seeAllReviewBtn(context),
      ],
    );
  }

  Widget _seeAllReviewBtn(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            Get.toNamed(AppRouteConst.allReviewScreen);
          },
          style: ButtonStyle(
            elevation: WidgetStateProperty.all<double>(0.0),
            backgroundColor:
            WidgetStateProperty.all<Color>(AppColors.primaryColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: AppColors.tertiaryColor,
                  width: 1.0,
                ),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 0.02.w(context), vertical: 0.005.h(context)),
            child: Text(
              "SEE ALL REVIEW",
              style: TextStyle(
                  fontSize: 0.014.toRes(context),
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w600),
            ),
          )),
    );
  }

  Widget _addToCartBtn(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            if (isBottomSheetOpen == true) {
              if (discoverCtrl.selectedSize.value <= 0.0 ) {
                CustomDialogues.flutterToastDialogueBox(
                    "Please select shoe size", color: AppColors.errorColor,
                    textColor: AppColors.primaryColor);
                discoverCtrl.cartProductQty.value = 1;
              }else{
                discoverCtrl.addDataToCart(
                    cPData.productId ?? "",
                    cPData.productPrice ?? 0.0,
                    discoverCtrl.cartProductQty.value,
                    cPData.productName ?? "",
                    discoverCtrl.selectedSize.toString(),
                    cPData.brandName ?? ""
                );
              }

            } else {
              _showAddToCartDesign(context);
            }
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
            child: Obx(
                  () =>
              discoverCtrl.isAddingToCart.isTrue
                  ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,),
              )
                  : Text(
                "ADD TO CART",
                style: TextStyle(
                    fontSize: 0.014.toRes(context),
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )),
    );
  }

  _showAddToCartDesign(BuildContext context) {
    discoverCtrl.cartProductQty.value = 1;
    if (!isBottomSheetOpen) {
      isBottomSheetOpen = true;
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return _addToCartDesign(context);
        },
      ).whenComplete(() {
        isBottomSheetOpen = false;
      });
    }
  }

  _addToCartDesign(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0.04.w(context), vertical: 0.02.h(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add to Cart",
                  style: TextStyle(
                      fontSize: 0.016.toRes(context),
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            Text("Quantity",
                style: TextStyle(
                    fontSize: 0.014.toRes(context),
                    fontWeight: FontWeight.bold)),
            Row(
              children: [
                Obx(() => Text("${discoverCtrl.cartProductQty.value}")),
                const Spacer(),
                _cartIncreaseAndDecrease(context, "-"),
                SizedBox(
                  width: 0.08.w(context),
                ),
                _cartIncreaseAndDecrease(context, "+"),
              ],
            ),
            const Divider(
              thickness: 1.0,
              color: AppColors.secondaryColor,
            ),
            SizedBox(
              height: 0.02.h(context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(fontSize: 0.012.toRes(context)),
                      ),
                      Text(
                        "\$${cPData.productPrice}",
                        style: TextStyle(
                            fontSize: 0.016.toRes(context),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  _addToCartBtn(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _cartIncreaseAndDecrease(BuildContext context, String info) {
    return InkWell(
      splashFactory: InkSplash.splashFactory,
      onTap: () {
        if (info.toLowerCase() == "-") {
          if (discoverCtrl.cartProductQty.value > 1) {
            discoverCtrl.cartProductQty.value--;
          }
        } else {
          discoverCtrl.cartProductQty.value++;
        }
      },
      child: Container(
          height: 0.1.h(context),
          width: 0.1.w(context),
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

  Widget _colorPickerDesign(String hexCode) {
    Color color = Color(int.parse(hexCode ?? "", radix: 16) + 0xFF000000);
    return InkWell(
      onTap: () {
        discoverCtrl.selectedImageHex.value = hexCode;
      },
      child: Obx(()=>
      Container(
          width: 32.0, // Adjust width as needed
          height: 32.0, // Adjust height as needed
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: discoverCtrl.selectedImageHex.value == hexCode
                  ? AppColors.secondaryColor // Highlight color when selected
                  : Colors.transparent, // Transparent border color when not selected
              width: 2.0, // Border width
            ),
          ),
          child: Center(
            child: Container(
              width: 24.0, // Adjust width of the inner circle
              height: 24.0, // Adjust height of the inner circle
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color, // Color of the inner circle
              ),
            ),
          ),
        ),
      ),
    );
  }

}
