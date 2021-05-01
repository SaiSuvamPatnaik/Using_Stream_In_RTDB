import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:streaminrtdb/Screen/trial.dart';

import 'Screen/trial.dart';

void main() {
  runApp(MaterialApp(
      home: MyApp()));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: trial(),
    );
  }
}
