import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoesly/app_routes/routes_const.dart';
import 'package:shoesly/constants/colors.dart';
import 'package:shoesly/constants/controllers.dart';
import 'package:shoesly/constants/extension.dart';
import 'package:shoesly/constants/images_const.dart';
import 'package:shoesly/global/my_app_bar.dart';
import 'package:shoesly/screens/discover_screen/controller/discover_controller.dart';
import 'package:shoesly/screens/discover_screen/models/combined_model.dart';

import '../../../global/fade_in_image_widget.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(DiscoverController());
    discoverCtrl.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: MyAppBar(
        title: "Discover",
        widList: [
          IconButton(
              onPressed: () {
                Get.toNamed(AppRouteConst.cartScreen);
              },
              icon: Image.asset(ImagesConst.bag))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30.0), // Adjust the radius as needed
          ),
          onPressed: () {
            Get.toNamed(AppRouteConst.productFilterScreen);
          },
          label: Row(
            children: [
              Image.asset(
                ImagesConst.setting,
              ),
              SizedBox(
                width: 0.02.w(context),
              ),
              Text(
                "FILTER",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 0.014.toRes(context)),
              )
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
        child: Obx(
          () => discoverCtrl.isFetchingProducts.isTrue
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    Text("Loading Products...")
                  ],
                )
              : discoverCtrl.filterProductsByBrand().isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 0.01.h(context),
                        ),
                        _topFilter(),
                        Expanded(
                          child: Center(
                            child: Text(
                              'No Brands',
                              style: TextStyle(
                                color: AppColors.darkGrey,
                                fontSize: 0.016.toRes(context),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                    children: [
                      SizedBox(
                        height: 0.01.h(context),
                      ),
                      _topFilter(),
                      SizedBox(
                        height: 0.01.h(context),
                      ),
                      _shoeListingGrid(),
                    ],
                  ),
        ),
      ),
    ));
  }

  Widget _topFilter() {
    return SizedBox(
      height: 0.04.h(context),
      child: ListView.builder(
          itemCount: discoverCtrl.brandList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            String filter = discoverCtrl.brandList[i];
            return GestureDetector(
              onTap: () {
                discoverCtrl.selectedFilter.value = filter;
                if (discoverCtrl.filterProductsByBrand().isEmpty) {
                  discoverCtrl.filterProductsByBrand();
                }
                discoverCtrl.selectedBrandName.value = "";
                discoverCtrl.minPrice.value = -1.0;
                discoverCtrl.maxPrice.value = -1.0;
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
                child: Obx(
                  () => Text(
                    filter,
                    style: TextStyle(
                        color: discoverCtrl.selectedFilter.value == filter
                            ? AppColors.secondaryColor
                            : AppColors.darkGrey,
                        fontWeight: discoverCtrl.selectedFilter.value == filter
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 0.014.toRes(context)),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _shoeListingGrid() {
    List<CombinedModel> filteredAndSortedData =
        discoverCtrl.filterAndSortProducts();
    return RefreshIndicator(
      onRefresh: ()async{
        discoverCtrl.getProducts();
      },
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: discoverCtrl.filterProductsByBrand().length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          CombinedModel cData = discoverCtrl.filterProductsByBrand()[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppRouteConst.discoverDetailScreen, arguments: cData);
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.04.w(context),
                            vertical: 0.01.h(context)),
                        child: FadedImageWidget(
                          imageUrl: (cData.pImages ?? []).isEmpty
                              ? ""
                              : cData.pImages?[0].images?[0] ?? "",
                          imagePlaceHolder: ImagesConst.product,
                          imageError: ImagesConst.product,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 8.0,
                        left: 8.0,
                        child: Visibility(
                            visible:
                                (cData.brandLogo ?? "").isEmpty ? false : true,
                            child: SizedBox(
                                height: 0.05.h(context),
                                width: 0.05.w(context),
                                child: Image.network(discoverCtrl
                                    .getImageUrl(cData.brandLogo ?? ""))))),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 0.015.w(context),
                      right: 0.015.w(context),
                      top: 0.01.h(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        discoverCtrl.truncateText("${cData.productName}",
                            maxLength: 20),
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 0.012.toRes(context)),
                      ),
                      SizedBox(width: 0.005.w(context)),
                      Row(
                        children: [
                          Icon(Icons.star,
                              color: Colors.yellow, size: 0.014.toRes(context)),
                          SizedBox(width: 0.005.w(context)),
                          Text(
                            "${cData.productReview}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 0.012.toRes(context)),
                          ),
                          SizedBox(width: 0.005.w(context)),
                          Text(
                            "(1045 Reviews)",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 0.012.toRes(context)),
                          ),
                        ],
                      ),
                      SizedBox(width: 0.01.w(context)),
                      Text(
                        "\$${cData.productPrice}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 0.014.toRes(context)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
