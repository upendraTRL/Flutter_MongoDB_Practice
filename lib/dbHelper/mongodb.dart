import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongodb_tut/dbHelper/constant.dart';
import 'package:mongodb_tut/model.dart';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    print('Inspect - ');
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<void> update(Model data) async {
    //Mongo CRUD - https://pub.dev/packages/mongo_dart

    var response = await userCollection.findOne({"_id": data.id});
    response["mobile"] = data.mobile;
    response["fname"] = data.fname;
    await userCollection.replaceOne({"_id": data.id}, response);

    inspect(response);
  }

  static delete(Model data) async {
    await userCollection.remove(where.id(data.id));
  }

  static Future<String> insert(Model data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return 'Data Inserted';
      } else {
        return 'Something went wrong while inserting!';
      }
    } catch (e) {
      print('Insert Exception - $e');
      return e.toString();
    }
  }
}
