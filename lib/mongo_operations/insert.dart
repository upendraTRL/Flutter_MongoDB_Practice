import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongodb_tut/dbHelper/mongodb.dart';
import 'package:mongodb_tut/model.dart';

class MongoInsert extends StatefulWidget {
  const MongoInsert({super.key});

  @override
  State<MongoInsert> createState() => _MongoInsertState();
}

class _MongoInsertState extends State<MongoInsert> {
  var mobileController = TextEditingController();
  var fNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                'Insert Data',
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: mobileController,
                decoration: const InputDecoration(labelText: 'Mobile'),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: fNameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: () => _fakeData(),
                      child: const Text('Generate Data')),
                  ElevatedButton(
                      onPressed: () => _insertData(
                          mobileController.text, fNameController.text),
                      child: const Text('Insert Data')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //Functions
  void _fakeData() {
    setState(() {
      mobileController.text = '1234567890';
      fNameController.text = faker.person.firstName();
    });
  }

  Future<void> _insertData(String mobileNo, String fName) async {
    var _id = M.ObjectId(); //THIS WILL USE FOR UNIQUE ID
    final data = Model(id: _id, mobile: mobileNo, fname: fName);
    // var result = await MongoDatabase.insert(data);
    await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Inserted ID - $mobileNo, ${_id.oid}")));
    _clearAll();
  }

  void _clearAll() {
    mobileController.text = "";
    fNameController.text = "";
  }
}
