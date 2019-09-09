import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Topilocal',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHome(),
    );
  }
}
