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
