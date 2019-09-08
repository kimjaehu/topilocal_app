import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SigninPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  
  final signinFormKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  bool validateAndSave(){
    final form = signinFormKey.currentState;
    if (form.validate()) {
      form.save();
      print('Form is valid. $_email, $_password');
      return true;
    } 
    return false;
  }

  void validateAndsubmit() async{
    if (validateAndSave()){
      try {
        FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: _email,
      password: _password,
    )).user;
        print('signedin ${user.uid}');
      }
      catch (error) {
        print('error $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Topilocal Signin'),
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: new Form(
          key: signinFormKey,
          child: new Column(
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Email'),
                validator: (value) => value.isEmpty ? 'Enter email.' : null,
                onSaved: (value) => _email = value,
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value.isEmpty ? 'Enter password.' : null,
                onSaved: (value) => _password = value,
              ),
              new RaisedButton(
                child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
                onPressed: validateAndsubmit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
