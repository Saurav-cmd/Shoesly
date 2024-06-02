import 'dart:convert';

ProductsImagesModel productsImagesModelFromJson(String str) => ProductsImagesModel.fromJson(json.decode(str));

String productsImagesModelToJson(ProductsImagesModel data) => json.encode(data.toJson());

class ProductsImagesModel {
  List<ImageDocument>? documents;

  ProductsImagesModel({
    this.documents,
  });

  factory ProductsImagesModel.fromJson(Map<String, dynamic> json) => ProductsImagesModel(
    documents: json["documents"] == null ? [] : List<ImageDocument>.from(json["documents"]!.map((x) => ImageDocument.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
  };
}

class ImageDocument {
  String? name;
  ProductFields? fields;
  DateTime? createTime;
  DateTime? updateTime;

  ImageDocument({
    this.name,
    this.fields,
    this.createTime,
    this.updateTime,
  });

  factory ImageDocument.fromJson(Map<String, dynamic> json) => ImageDocument(
    name: json["name"],
    fields: json["fields"] == null ? null : ProductFields.fromJson(json["fields"]),
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

class ProductFields {
  PImages? images;
  ProductId? productId;
  ColorHex? colorHex;
  ColorHex? colorName;

  ProductFields({
    this.images,
    this.productId,
    this.colorHex,
    this.colorName,
  });

  factory ProductFields.fromJson(Map<String, dynamic> json) => ProductFields(
    images: json["images"] == null ? null : PImages.fromJson(json["images"]),
    productId: json["productId"] == null ? null : ProductId.fromJson(json["productId"]),
    colorHex: json["colorHex"] == null ? null : ColorHex.fromJson(json["colorHex"]),
    colorName: json["colorName"] == null ? null : ColorHex.fromJson(json["colorName"]),
  );

  Map<String, dynamic> toJson() => {
    "images": images?.toJson(),
    "productId": productId?.toJson(),
    "colorHex": colorHex?.toJson(),
    "colorName": colorName?.toJson(),
  };
}

class ColorHex {
  String? stringValue;

  ColorHex({
    this.stringValue,
  });

  factory ColorHex.fromJson(Map<String, dynamic> json) => ColorHex(
    stringValue: json["stringValue"],
  );

  Map<String, dynamic> toJson() => {
    "stringValue": stringValue,
  };
}

class PImages {
  ArrayValue? arrayValue;

  PImages({
    this.arrayValue,
  });

  factory PImages.fromJson(Map<String, dynamic> json) => PImages(
    arrayValue: json["arrayValue"] == null ? null : ArrayValue.fromJson(json["arrayValue"]),
  );

  Map<String, dynamic> toJson() => {
    "arrayValue": arrayValue?.toJson(),
  };
}

class ArrayValue {
  List<ColorHex>? values;

  ArrayValue({
    this.values,
  });

  factory ArrayValue.fromJson(Map<String, dynamic> json) => ArrayValue(
    values: json["values"] == null ? [] : List<ColorHex>.from(json["values"]!.map((x) => ColorHex.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x.toJson())),
  };
}

class ProductId {
  String? referenceValue;

  ProductId({
    this.referenceValue,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    referenceValue: json["referenceValue"],
  );

  Map<String, dynamic> toJson() => {
    "referenceValue": referenceValue,
  };
}
