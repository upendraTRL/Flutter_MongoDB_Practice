import 'package:mongo_dart/mongo_dart.dart';

import 'dart:convert';

Model mongoDbModelFromJson(String str) => Model.fromJson(json.decode(str));

String mongoDbModelToJson(Model data) => json.encode(data.toJson());

class Model {
  ObjectId id;
  String mobile;
  String fname;
  // String lat;
  // String long;
  // String address;

  Model({
    required this.id,
    required this.mobile,
    required this.fname,
    // required this.lat,
    // required this.long,
    // required this.address,
  });

  factory Model.fromJson(Map<String, dynamic> json) =>
      Model(id: json['_id'], mobile: json['mobile'], fname: json['fname']);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "mobile": mobile,
        "fname": fname,
      };
}
