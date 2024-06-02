// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  List<Document>? documents;

  CartModel({
    this.documents,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
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
  BrandName? title;
  BrandName? productId;
  Price? price;
  BrandName? size;
  Quantity? quantity;
  BrandName? image;
  BrandName? colorHexCode;
  BrandName? brandName;
  BrandName? color;

  Fields({
    this.title,
    this.productId,
    this.price,
    this.size,
    this.quantity,
    this.image,
    this.colorHexCode,
    this.brandName,
    this.color,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    title: json["title"] == null ? null : BrandName.fromJson(json["title"]),
    productId: json["productId"] == null ? null : BrandName.fromJson(json["productId"]),
    price: json["price"] == null ? null : Price.fromJson(json["price"]),
    size: json["size"] == null ? null : BrandName.fromJson(json["size"]),
    quantity: json["quantity"] == null ? null : Quantity.fromJson(json["quantity"]),
    image: json["image"] == null ? null : BrandName.fromJson(json["image"]),
    colorHexCode: json["colorHexCode"] == null ? null : BrandName.fromJson(json["colorHexCode"]),
    brandName: json["brandName"] == null ? null : BrandName.fromJson(json["brandName"]),
    color: json["color"] == null ? null : BrandName.fromJson(json["color"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title?.toJson(),
    "productId": productId?.toJson(),
    "price": price?.toJson(),
    "size": size?.toJson(),
    "quantity": quantity?.toJson(),
    "image": image?.toJson(),
    "colorHexCode": colorHexCode?.toJson(),
    "brandName": brandName?.toJson(),
    "color": color?.toJson(),
  };
}

class BrandName {
  String? stringValue;

  BrandName({
    this.stringValue,
  });

  factory BrandName.fromJson(Map<String, dynamic> json) => BrandName(
    stringValue: json["stringValue"],
  );

  Map<String, dynamic> toJson() => {
    "stringValue": stringValue,
  };
}

class Price {
  int? doubleValue;

  Price({
    this.doubleValue,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    doubleValue: json["doubleValue"],
  );

  Map<String, dynamic> toJson() => {
    "doubleValue": doubleValue,
  };
}

class Quantity {
  String? integerValue;

  Quantity({
    this.integerValue,
  });

  factory Quantity.fromJson(Map<String, dynamic> json) => Quantity(
    integerValue: json["integerValue"],
  );

  Map<String, dynamic> toJson() => {
    "integerValue": integerValue,
  };
}
