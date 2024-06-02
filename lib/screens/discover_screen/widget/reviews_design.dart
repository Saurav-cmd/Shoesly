import 'package:flutter/material.dart';
import 'package:shoesly/constants/controllers.dart';
import 'package:shoesly/constants/extension.dart';
import 'package:shoesly/constants/images_const.dart';
import 'package:shoesly/global/rating_builder.dart';
import 'package:shoesly/screens/reviews_screen/model/review_custom_model.dart';

import '../../../constants/colors.dart';
import '../../../global/fade_in_image_widget.dart';

class ReviewsDesign extends StatelessWidget {
  const ReviewsDesign({super.key,this.reviewData});
  final CustomReviewModel? reviewData;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading:Container(
        width: 0.13.w(context),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black54.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: FadedImageWidget(
            imageUrl: "${reviewData?.personImage}",
            imagePlaceHolder: ImagesConst.bag,
            imageError: ImagesConst.bag,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text("${reviewData?.personFirstName} ${reviewData?.personSecondName}",style: TextStyle(fontSize: 0.014.toRes(context), fontWeight: FontWeight.bold),),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.005.h(context),),
          RatingBuilder(rating: double.parse("${reviewData?.reviewNumber}"),),
          Text("${reviewData?.review}",style: TextStyle(fontSize: 0.012.toRes(context)),),
          SizedBox(height: 0.005.h(context),),
        ],
      ),
      trailing: Text(discoverCtrl.getFormattedDate(reviewData?.reviewDate ?? DateTime.now().toString())),
    );
  }
}
