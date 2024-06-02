import 'dart:convert';

ReviewsModel reviewsModelFromJson(String str) => ReviewsModel.fromJson(json.decode(str));

String reviewsModelToJson(ReviewsModel data) => json.encode(data.toJson());

class ReviewsModel {
  List<ReviewDocument>? documents;

  ReviewsModel({
    this.documents,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
    documents: json["documents"] == null ? [] : List<ReviewDocument>.from(json["documents"]!.map((x) => ReviewDocument.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
  };
}

class ReviewDocument {
  String? name;
  ReviewsFields? fields;
  DateTime? createTime;
  DateTime? updateTime;

  ReviewDocument({
    this.name,
    this.fields,
    this.createTime,
    this.updateTime,
  });

  factory ReviewDocument.fromJson(Map<String, dynamic> json) => ReviewDocument(
    name: json["name"],
    fields: json["fields"] == null ? null : ReviewsFields.fromJson(json["fields"]),
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

class ReviewsFields {
  DateAndTime? description;
  Id? productId;
  DateAndTime? dateAndTime;
  ReviewNumber? reviewNumber;
  Id? userId;

  ReviewsFields({
    this.description,
    this.productId,
    this.dateAndTime,
    this.reviewNumber,
    this.userId,
  });

  factory ReviewsFields.fromJson(Map<String, dynamic> json) => ReviewsFields(
    description: json["description"] == null ? null : DateAndTime.fromJson(json["description"]),
    productId: json["productId"] == null ? null : Id.fromJson(json["productId"]),
    dateAndTime: json["dateAndTime"] == null ? null : DateAndTime.fromJson(json["dateAndTime"]),
    reviewNumber: json["reviewNumber"] == null ? null : ReviewNumber.fromJson(json["reviewNumber"]),
    userId: json["userId"] == null ? null : Id.fromJson(json["userId"]),
  );

  Map<String, dynamic> toJson() => {
    "description": description?.toJson(),
    "productId": productId?.toJson(),
    "dateAndTime": dateAndTime?.toJson(),
    "reviewNumber": reviewNumber?.toJson(),
    "userId": userId?.toJson(),
  };
}

class DateAndTime {
  String? stringValue;

  DateAndTime({
    this.stringValue,
  });

  factory DateAndTime.fromJson(Map<String, dynamic> json) => DateAndTime(
    stringValue: json["stringValue"],
  );

  Map<String, dynamic> toJson() => {
    "stringValue": stringValue,
  };
}

class Id {
  String? referenceValue;

  Id({
    this.referenceValue,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    referenceValue: json["referenceValue"],
  );

  Map<String, dynamic> toJson() => {
    "referenceValue": referenceValue,
  };
}

class ReviewNumber {
  String? integerValue;

  ReviewNumber({
    this.integerValue,
  });

  factory ReviewNumber.fromJson(Map<String, dynamic> json) => ReviewNumber(
    integerValue: json["integerValue"],
  );

  Map<String, dynamic> toJson() => {
    "integerValue": integerValue,
  };
}
