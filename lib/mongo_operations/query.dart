import 'package:flutter/material.dart';
import 'package:mongodb_tut/dbHelper/mongodb.dart';
import 'package:mongodb_tut/model.dart';

class QueryDb extends StatefulWidget {
  const QueryDb({super.key});

  @override
  State<QueryDb> createState() => _QueryDbState();
}

class _QueryDbState extends State<QueryDb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getQueryData(),
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

  Widget displayCard(Model data) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name - ${data.fname}',
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              Text(
                'Mobile - ${data.mobile}',
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
