import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './home.dart';
import './views/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Topilocal',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      // home: MyHome(),
      home: LandingPage(),
      routes: <String, WidgetBuilder> {
        '/signUp': (BuildContext context) => MyHome(),
        '/home': (BuildContext context) => MyHome(),
      },
    );
  }
}
