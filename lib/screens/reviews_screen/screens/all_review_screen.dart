import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoesly/constants/colors.dart';
import 'package:shoesly/constants/controllers.dart';
import 'package:shoesly/constants/extension.dart';
import 'package:shoesly/global/my_app_bar.dart';
import 'package:shoesly/screens/discover_screen/widget/reviews_design.dart';
import 'package:shoesly/screens/reviews_screen/model/review_custom_model.dart';

class AllReviewScreen extends StatelessWidget {
  AllReviewScreen({super.key});
  final selectedFilter = "All".obs;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: MyAppBar(
          automaticLeading: true,
          title: "Review (${discoverCtrl.customReviewData.length})",
          widList: [
            const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Obx(() => Text(
              "${discoverCtrl.averageRating}",
              style: TextStyle(
                  fontSize: 0.012.toRes(context),
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(
              width: 0.04.w(context),
            ),
          ],
          centerTile: true,
        ),
        body: Obx(
              () => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 0.02.h(context)),
                _topFilter(context),
                SizedBox(height: 0.02.h(context)),
                if (_filteredReviews().isEmpty)
                  Center(
                    child: Text(
                      'No reviews',
                      style: TextStyle(color: AppColors.darkGrey,fontSize: 0.016.toRes(context)),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredReviews().length,
                    itemBuilder: (ctx, i) {
                      CustomReviewModel data = _filteredReviews()[i];
                      return ReviewsDesign(reviewData: data);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topFilter(BuildContext context) {
    return SizedBox(
      height: 0.04.h(context),
      child: ListView.builder(
        itemCount: discoverCtrl.reviewsList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, i) {
          String filter = discoverCtrl.reviewsList[i];
          return GestureDetector(
            onTap: () {
              selectedFilter.value = filter;
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
              child: Obx(
                    () => Text(
                  filter,
                  style: TextStyle(
                    color: selectedFilter.value == filter
                        ? AppColors.secondaryColor
                        : AppColors.darkGrey,
                    fontWeight: selectedFilter.value == filter
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 0.014.toRes(context)
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<CustomReviewModel> _filteredReviews() {
    if (selectedFilter.value == "All") {
      return discoverCtrl.customReviewData;
    } else {
      int starRating = int.parse(selectedFilter.value.split(' ')[0]);
      return discoverCtrl.customReviewData
          .where((review) => review.reviewNumber == starRating)
          .toList();
    }
  }
}
