import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shoesly/constants/extension.dart';

class RatingBuilder extends StatelessWidget {
  const RatingBuilder({super.key, this.rating});
  final double? rating;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating ?? 0.0,
      itemCount: 5,
      itemSize: 0.014.toRes(context),
      physics:const BouncingScrollPhysics(),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
    );
  }
}
