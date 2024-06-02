import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoesly/app_routes/routes_const.dart';
import 'package:shoesly/constants/colors.dart';
import 'package:shoesly/constants/controllers.dart';
import 'package:shoesly/constants/extension.dart';
import 'package:shoesly/constants/images_const.dart';
import 'package:shoesly/global/my_app_bar.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../models/brand_model.dart';

class ProductFilterScreen extends StatefulWidget {
  const ProductFilterScreen({super.key});

  @override
  State<ProductFilterScreen> createState() => _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen> {
  RxInt filterCount = 0.obs;
  SfRangeValues _values = const SfRangeValues(40.0, 80.0);
  RxList<String> sortBy =
      RxList(["Most Recent", "Lowest Price", "Highest Price"]);
  RxList<String> gender = RxList(["Man", "Women", "Unisex"]);
  RxList<String> colorValue = RxList(["Black", "White", "Red"]);
  RxList<Color> colorHexValue =
      RxList([Colors.black, Colors.white, Colors.red]);
  final RxList<BrandModel> _brandData = RxList([
    BrandModel(
      id: "001",
      brandName: "Nike",
      brandLogo: ImagesConst.nike,
      totalQuantity: 505,
    ),
    BrandModel(
      id: "002",
      brandName: "Reebok",
      brandLogo: ImagesConst.reebok,
      totalQuantity: 505,
    ),
    BrandModel(
      id: "003",
      brandName: "Adidas",
      brandLogo: ImagesConst.adidas,
      totalQuantity: 505,
    ),
    BrandModel(
      id: "0034",
      brandName: "Puma",
      brandLogo: ImagesConst.puma,
      totalQuantity: 505,
    ),
  ]);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    discoverCtrl.priceRangeFilterApplied.value = false;
    discoverCtrl.sortByFilterApplied.value = false;
    discoverCtrl.genderFilterApplied.value = false;
    discoverCtrl.colorFilterApplied.value = false;
    discoverCtrl.totalFilterCount.value = 0;
    discoverCtrl.brandFilterApplied.value = false;

    discoverCtrl.selectedBrandIndex.value = -1;
    discoverCtrl.selectedSortByIndex.value = -1;
    discoverCtrl.selectedGenderIndex.value = -1;
    discoverCtrl.selectedColorIndex.value = -1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: MyAppBar(
          automaticLeading: true,
          title: "Filter",
          centerTile: true,
        ),
        bottomNavigationBar: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_resetBtn(context), _applyBtn(context)],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.02.h(context),
              ),
              _headerText("Brands"),
              _brandsDesign(),
              _headerText("Price Range"),
              _priceRangeSlider(),
              SizedBox(
                height: 0.04.h(context),
              ),
              _headerText("Sort By"),
              _sortByDesign(),
              SizedBox(
                height: 0.04.h(context),
              ),
              _headerText("Gender"),
              _genderDesign(),
              SizedBox(
                height: 0.04.h(context),
              ),
              _headerText("Color"),
              _colorDesign(),
            ],
          ),
        ),
      ),
    );
  }

  _headerText(String title, {double? fontSize}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
      child: Text(
        title,
        style: TextStyle(
            fontSize: fontSize ?? 0.016.toRes(context),
            fontWeight: FontWeight.w500),
      ),
    );
  }

  _priceRangeSlider() {
    return SfRangeSlider(
      min: 0.0,
      max: 400.0,
      values: _values,
      interval: 50,
      showTicks: true,
      showLabels: true,
      enableTooltip: true,
      activeColor: AppColors.secondaryColor,
      minorTicksPerInterval: 5,
      onChanged: (SfRangeValues values) {
        setState(() {
          _values = values;
        });
        discoverCtrl.minPrice.value = double.parse(values.start.toString());
        discoverCtrl.maxPrice.value = double.parse(values.end.toString());
      },
    );
  }

  _sortByDesign() {
    return Padding(
      padding: EdgeInsets.only(left: 0.035.w(context), top: 0.02.h(context)),
      child: SizedBox(
        height: 0.05.h(context),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sortBy.length,
            itemBuilder: (ctx, i) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.02.w(context)),
                child: GestureDetector(
                  onTap: () {
                    discoverCtrl.selectedSortByIndex.value = i;
                    if (discoverCtrl.sortByFilterApplied.isFalse) {
                      discoverCtrl.totalFilterCount.value += 1;
                      discoverCtrl.sortByFilterApplied.value = true;
                    }
                    _applySorting(sortBy[i]);
                  },
                  child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                          color: discoverCtrl.selectedSortByIndex.value == i
                              ? AppColors.secondaryColor
                              : AppColors.tertiaryColor,
                          borderRadius: BorderRadius.circular(40.0)),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.04.w(context),
                        ),
                        child: Text(
                          sortBy[i],
                          style: TextStyle(
                              color: discoverCtrl.selectedSortByIndex.value == i
                                  ? AppColors.primaryColor
                                  : AppColors.darkGrey,
                              fontSize: 0.014.toRes(context)),
                        ),
                      )),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  _genderDesign() {
    return Padding(
      padding: EdgeInsets.only(left: 0.035.w(context), top: 0.02.h(context)),
      child: SizedBox(
        height: 0.05.h(context),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: gender.length,
            itemBuilder: (ctx, i) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.02.w(context)),
                child: GestureDetector(
                  onTap: () {
                    discoverCtrl.selectedGenderIndex.value = i;
                    if (discoverCtrl.genderFilterApplied.isFalse) {
                      discoverCtrl.totalFilterCount.value += 1;
                      discoverCtrl.genderFilterApplied.value = true;
                    }
                  },
                  child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                          color: discoverCtrl.selectedGenderIndex.value == i
                              ? AppColors.secondaryColor
                              : AppColors.tertiaryColor,
                          borderRadius: BorderRadius.circular(40.0)),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.04.w(context),
                        ),
                        child: Text(
                          gender[i],
                          style: TextStyle(
                              color: discoverCtrl.selectedGenderIndex.value == i
                                  ? AppColors.primaryColor
                                  : AppColors.darkGrey,
                              fontSize: 0.014.toRes(context)),
                        ),
                      )),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  _colorDesign() {
    return Padding(
      padding: EdgeInsets.only(left: 0.035.w(context), top: 0.02.h(context)),
      child: SizedBox(
        height: 0.05.h(context),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colorValue.length,
            itemBuilder: (ctx, i) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.02.w(context)),
                child: GestureDetector(
                  onTap: () {
                    discoverCtrl.selectedColorIndex.value = i;
                    if (discoverCtrl.colorFilterApplied.isFalse) {
                      discoverCtrl.totalFilterCount.value += 1;
                      discoverCtrl.colorFilterApplied.value = true;
                    }
                  },
                  child: Obx(
                    () => Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    discoverCtrl.selectedColorIndex.value == i
                                        ? AppColors.secondaryColor
                                        : AppColors.tertiaryColor),
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 0.02.w(context),
                            ),
                            Container(
                              height: 0.05.h(context),
                              width: 0.05.w(context),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colorHexValue[i],
                                  border: Border.all(
                                      color: colorHexValue[i] == Colors.white
                                          ? AppColors.darkGrey
                                          : AppColors.tertiaryColor)),
                            ),
                            Center(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0.04.w(context),
                              ),
                              child: Text(
                                colorValue[i],
                                style: TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontSize: 0.014.toRes(context)),
                              ),
                            )),
                          ],
                        )),
                  ),
                ),
              );
            }),
      ),
    );
  }

  _brandsDesign() {
    return Padding(
      padding: EdgeInsets.only(left: 0.035.w(context), top: 0.02.h(context)),
      child: SizedBox(
        height: 0.15.h(context),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _brandData.length,
          itemBuilder: (ctx, i) {
            BrandModel data = _brandData[i];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.02.w(context)),
              child: GestureDetector(
                onTap: () {
                  discoverCtrl.selectedBrandIndex.value = i;
                  if (discoverCtrl.brandFilterApplied.isFalse) {
                    discoverCtrl.totalFilterCount.value += 1;
                    discoverCtrl.brandFilterApplied.value = true;
                  }
                  discoverCtrl.selectedBrandName.value = data.brandName;
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: discoverCtrl.selectedBrandIndex.value == i
                                ? AppColors.successColor
                                : AppColors.tertiaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: AppColors.tertiaryColor,
                          maxRadius: 0.025.toRes(context),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.02.w(context),
                                  vertical: 0.01.h(context)),
                              child: Image.asset(data.brandLogo),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      data.brandName,
                      style: TextStyle(
                        fontSize: 0.014.toRes(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _applyBtn(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            discoverCtrl.filterProductsByBrand();
            Get.back();
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
                horizontal: 0.05.w(context), vertical: 0.01.h(context)),
            child: Text(
              "Apply",
              style: TextStyle(
                  fontSize: 0.014.toRes(context),
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600),
            ),
          )),
    );
  }

  Widget _resetBtn(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            discoverCtrl.priceRangeFilterApplied.value = false;
            discoverCtrl.sortByFilterApplied.value = false;
            discoverCtrl.genderFilterApplied.value = false;
            discoverCtrl.colorFilterApplied.value = false;
            discoverCtrl.brandFilterApplied.value = false;
            discoverCtrl.totalFilterCount.value = 0;

            discoverCtrl.selectedBrandIndex.value = -1;
            discoverCtrl.selectedSortByIndex.value = -1;
            discoverCtrl.selectedGenderIndex.value = -1;
            discoverCtrl.selectedColorIndex.value = -1;
          },
          style: ButtonStyle(
            elevation: WidgetStateProperty.all<double>(0.0),
            backgroundColor:
                WidgetStateProperty.all<Color>(AppColors.primaryColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: AppColors.darkGrey,
                  width: 1.0,
                ),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 0.02.w(context), vertical: 0.005.h(context)),
            child: Obx(
              () => Text(
                "Reset (${discoverCtrl.totalFilterCount})",
                style: TextStyle(
                    fontSize: 0.014.toRes(context),
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )),
    );
  }


  void _applySorting(String sortBy) {
    switch (sortBy) {
      case "Most Recent":
      // Implement logic to sort by most recent
        discoverCtrl.sortByMostRecent();
        break;
      case "Lowest Price":
      // Implement logic to sort by lowest price
        discoverCtrl.sortByLowestPrice();
        break;
      case "Highest Price":
      // Implement logic to sort by highest price
        discoverCtrl.sortByHighestPrice();
        break;
    }
  }
}
