import 'dart:convert';

UsersModel usersModelFromJson(String str) => UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  List<UserDocument>? documents;

  UsersModel({
    this.documents,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
    documents: json["documents"] == null ? [] : List<UserDocument>.from(json["documents"]!.map((x) => UserDocument.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
  };
}

class UserDocument {
  String? name;
  UserFields? fields;
  DateTime? createTime;
  DateTime? updateTime;

  UserDocument({
    this.name,
    this.fields,
    this.createTime,
    this.updateTime,
  });

  factory UserDocument.fromJson(Map<String, dynamic> json) => UserDocument(
    name: json["name"],
    fields: json["fields"] == null ? null : UserFields.fromJson(json["fields"]),
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

class UserFields {
  FirstName? image;
  FirstName? paymentMethod;
  FirstName? firstName;
  FirstName? location;
  FirstName? lastName;

  UserFields({
    this.image,
    this.paymentMethod,
    this.firstName,
    this.location,
    this.lastName,
  });

  factory UserFields.fromJson(Map<String, dynamic> json) => UserFields(
    image: json["image"] == null ? null : FirstName.fromJson(json["image"]),
    paymentMethod: json["paymentMethod"] == null ? null : FirstName.fromJson(json["paymentMethod"]),
    firstName: json["firstName"] == null ? null : FirstName.fromJson(json["firstName"]),
    location: json["location"] == null ? null : FirstName.fromJson(json["location"]),
    lastName: json["lastName"] == null ? null : FirstName.fromJson(json["lastName"]),
  );

  Map<String, dynamic> toJson() => {
    "image": image?.toJson(),
    "paymentMethod": paymentMethod?.toJson(),
    "firstName": firstName?.toJson(),
    "location": location?.toJson(),
    "lastName": lastName?.toJson(),
  };
}

class FirstName {
  String? stringValue;

  FirstName({
    this.stringValue,
  });

  factory FirstName.fromJson(Map<String, dynamic> json) => FirstName(
    stringValue: json["stringValue"],
  );

  Map<String, dynamic> toJson() => {
    "stringValue": stringValue,
  };
}
