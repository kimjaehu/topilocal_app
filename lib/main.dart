import 'package:flutter/material.dart';

import './signin_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(title: 'Topilocal',
      theme: new ThemeData(primarySwatch: Colors.blue,),
      home: new SigninPage(),
    );
  }
}