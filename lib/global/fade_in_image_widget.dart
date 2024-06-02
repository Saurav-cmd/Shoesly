import 'package:flutter/material.dart';

class FadedImageWidget extends StatelessWidget {
  const FadedImageWidget({
    required this.imageUrl,
    required this.imagePlaceHolder,
    required this.imageError,
    this.fit,
    this.height,
    this.width,
    super.key,
  });

  final String imageUrl;
  final String imagePlaceHolder;
  final String imageError;
  final BoxFit? fit;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: width != null && height != null ? width! / height! : 1.0,
      child: FadeInImage(
        height: height,
        width: width,
        placeholder: AssetImage(imagePlaceHolder),
        image: NetworkImage(imageUrl),
        imageErrorBuilder: (context, error, stackTrace) => Image.asset(
          imageError,
          fit: fit ?? BoxFit.contain,
        ),
        fit: fit ?? BoxFit.fill,
        placeholderFit: fit ?? BoxFit.fill,
      ),
    );
  }
}

