import 'package:flutter/material.dart';
import 'package:mongodb_tut/dbHelper/mongodb.dart';
import 'package:mongodb_tut/model.dart';

class MongoDisplay extends StatefulWidget {
  const MongoDisplay({super.key});

  @override
  State<MongoDisplay> createState() => _MongoDisplayState();
}

class _MongoDisplayState extends State<MongoDisplay> {
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
        child: Column(
          children: [
            Text('Username - ${data.fname}'),
            const SizedBox(height: 5),
            Text('Mobile No - ${data.mobile}'),
          ],
        ),
      ),
    );
  }
}
