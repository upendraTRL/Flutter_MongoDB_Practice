import 'package:flutter/material.dart';
import 'package:mongodb_tut/dbHelper/mongodb.dart';
import 'package:mongodb_tut/model.dart';

class MongoDelete extends StatefulWidget {
  const MongoDelete({super.key});

  @override
  State<MongoDelete> createState() => _MongoDeleteState();
}

class _MongoDeleteState extends State<MongoDelete> {
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
                  MongoDatabase.delete(data);
                  setState(() {});
                  // print("ID - ${data.fname}");
                },
                icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
