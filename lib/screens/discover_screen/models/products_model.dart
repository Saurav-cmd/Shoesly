// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  List<Document>? documents;

  ProductsModel({
    this.documents,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    documents: json["documents"] == null ? [] : List<Document>.from(json["documents"]!.map((x) => Document.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
  };
}

class Document {
  String? name;
  Fields? fields;
  DateTime? createTime;
  DateTime? updateTime;

  Document({
    this.name,
    this.fields,
    this.createTime,
    this.updateTime,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    name: json["name"],
    fields: json["fields"] == null ? null : Fields.fromJson(json["fields"]),
    createTime: json["createTime"] == null ? null : DateTime.parse(json["createTime"]),
    updateTime: json["updateTime"] == null ? null : DateTime.parse(json["updateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "fields": fields?.toJson(),
    "createTime": createTime?.toIso8601String(),
    "updateTime": updateTime?.toIso8601String(),
  };
}

class Fields {
  ProductReview? productReview;
  BrandLogo? brandName;
  BrandLogo? gender;
  BrandLogo? brandLogo;
  Sizes? sizes;
  ReviewId? reviewId;
  ProductPrice? quantity;
  BrandLogo? productName;
  ProductPrice? productPrice;
  BrandLogo? productDescription;

  Fields({
    this.productReview,
    this.brandName,
    this.gender,
    this.brandLogo,
    this.sizes,
    this.reviewId,
    this.quantity,
    this.productName,
    this.productPrice,
    this.productDescription,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    productReview: json["productReview"] == null ? null : ProductReview.fromJson(json["productReview"]),
    brandName: json["brandName"] == null ? null : BrandLogo.fromJson(json["brandName"]),
    gender: json["gender"] == null ? null : BrandLogo.fromJson(json["gender"]),
    brandLogo: json["brandLogo"] == null ? null : BrandLogo.fromJson(json["brandLogo"]),
    sizes: json["sizes"] == null ? null : Sizes.fromJson(json["sizes"]),
    reviewId: json["reviewId"] == null ? null : ReviewId.fromJson(json["reviewId"]),
    quantity: json["quantity"] == null ? null : ProductPrice.fromJson(json["quantity"]),
    productName: json["productName"] == null ? null : BrandLogo.fromJson(json["productName"]),
    productPrice: json["productPrice"] == null ? null : ProductPrice.fromJson(json["productPrice"]),
    productDescription: json["productDescription"] == null ? null : BrandLogo.fromJson(json["productDescription"]),
  );

  Map<String, dynamic> toJson() => {
    "productReview": productReview?.toJson(),
    "brandName": brandName?.toJson(),
    "gender": gender?.toJson(),
    "brandLogo": brandLogo?.toJson(),
    "sizes": sizes?.toJson(),
    "reviewId": reviewId?.toJson(),
    "quantity": quantity?.toJson(),
    "productName": productName?.toJson(),
    "productPrice": productPrice?.toJson(),
    "productDescription": productDescription?.toJson(),
  };
}

class BrandLogo {
  String? stringValue;

  BrandLogo({
    this.stringValue,
  });

  factory BrandLogo.fromJson(Map<String, dynamic> json) => BrandLogo(
    stringValue: json["stringValue"],
  );

  Map<String, dynamic> toJson() => {
    "stringValue": stringValue,
  };
}

class ProductPrice {
  String? integerValue;

  ProductPrice({
    this.integerValue,
  });

  factory ProductPrice.fromJson(Map<String, dynamic> json) => ProductPrice(
    integerValue: json["integerValue"],
  );

  Map<String, dynamic> toJson() => {
    "integerValue": integerValue,
  };
}

class ProductReview {
  double? doubleValue;

  ProductReview({
    this.doubleValue,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) => ProductReview(
    doubleValue: json["doubleValue"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "doubleValue": doubleValue,
  };
}

class ReviewId {
  String? referenceValue;

  ReviewId({
    this.referenceValue,
  });

  factory ReviewId.fromJson(Map<String, dynamic> json) => ReviewId(
    referenceValue: json["referenceValue"],
  );

  Map<String, dynamic> toJson() => {
    "referenceValue": referenceValue,
  };
}

class Sizes {
  ArrayValue? arrayValue;

  Sizes({
    this.arrayValue,
  });

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
    arrayValue: json["arrayValue"] == null ? null : ArrayValue.fromJson(json["arrayValue"]),
  );

  Map<String, dynamic> toJson() => {
    "arrayValue": arrayValue?.toJson(),
  };
}

class ArrayValue {
  List<BrandLogo>? values;

  ArrayValue({
    this.values,
  });

  factory ArrayValue.fromJson(Map<String, dynamic> json) => ArrayValue(
    values: json["values"] == null ? [] : List<BrandLogo>.from(json["values"]!.map((x) => BrandLogo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x.toJson())),
  };
}
