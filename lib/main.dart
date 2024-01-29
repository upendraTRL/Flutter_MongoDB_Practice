import 'package:flutter/material.dart';
import 'package:mongodb_tut/dbHelper/mongodb.dart';
import 'package:mongodb_tut/mongo_operations/delete.dart';
import 'package:mongodb_tut/mongo_operations/display.dart';
import 'package:mongodb_tut/mongo_operations/insert.dart';
import 'package:mongodb_tut/mongo_operations/update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // return MongoInsert();
    // return MongoDisplay();
    // return MongoUpdate();
    return MongoDelete();
  }
}
