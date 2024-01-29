import 'package:flutter/material.dart';
import 'package:mongodb_tut/dbHelper/mongodb.dart';
import 'package:mongodb_tut/model.dart';
import 'package:mongodb_tut/mongo_operations/insert.dart';

class MongoUpdate extends StatefulWidget {
  const MongoUpdate({super.key});

  @override
  State<MongoUpdate> createState() => _MongoUpdateState();
}

class _MongoUpdateState extends State<MongoUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, AsyncSnapshot snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapShot.hasData) {
                //Data available
                var recordsLength = snapShot.data.length;
                return ListView.builder(
                  itemCount: recordsLength,
                  itemBuilder: (context, index) {
                    return displayCard(Model.fromJson(snapShot.data[index]));
                  },
                );
                // print('Total Data ${totalData.toString()}');
                // return const Text('Data found');
              } else {
                //Data available
                return const Center(
                  child: Text('No Data Available'),
                );
              }
            }
          },
        ),
      ),
    );
  }

  //Data display Widget
  Widget displayCard(Model data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name - ${data.fname}'),
                const SizedBox(height: 5),
                Text('Mobile - ${data.mobile}'),
              ],
            ),
            IconButton(
                onPressed: () {
                  //On Edit navigate to insert page with passing data (Model Class)
                  //as arguments
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) {
                                return MongoInsert();
                              },
                              settings: RouteSettings(arguments: data)))
                      .then((value) {
                    setState(() {});
                  });
                },
                icon: Icon(Icons.edit)),
          ],
        ),
      ),
    );
  }
}
