
class CombinedModel{
  String? productId;
  String? productName;
  String? productDescription;
  double? productPrice;
  double? productReview;
  int? quantity;
  String? reviewId;
  List<String>? shoeSizes;
  String? brandName;
  String? brandLogo;
  String? gender;
  List<ProductImages>? pImages;
  DateTime? productDate;

  CombinedModel({
    this.productId,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productReview,
    this.quantity,
    this.reviewId,
    this.shoeSizes,
    this.brandName,
    this.brandLogo,
    this.gender,
    this.pImages,
    this.productDate
  });
}

class ProductImages{
  String? imageId;
  String? colorHex;
  String? colorName;
  String? productId;
  List<String>? images;

  ProductImages({
    this.imageId,
    this.colorHex,
    this.colorName,
    this.images,
    this.productId
  });
}