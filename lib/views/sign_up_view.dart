import 'package:flutter/material.dart';
import 'package:topilocal_app/services/auth_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:topilocal_app/widgets/provider_widget.dart';

// Todo move this to color location
final primaryColor = const Color(0xFF966fd6);

enum AuthFormType { signIn, signUp, reset, anonymous }

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;

  SignUpView({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() =>
      _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  AuthFormType authFormType;
  _SignUpViewState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _warning;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == 'signUp') {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        if (authFormType == AuthFormType.signIn) {
          String uid = await auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in with ${uid}');
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (authFormType == AuthFormType.reset) {
          await auth.sendPasswordResetEmail(_email);
          print('password reset email sent');
          _warning = 'A password reset link has been sent to $_email';
          setState(() {
            authFormType = AuthFormType.signIn;
          });
        } else {
          String uid =
              await auth.createUserWithEmailAndPassword(_email, _password);
          print('Signed up with new ${uid}');
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        setState(() {
          _warning = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if (authFormType == AuthFormType.anonymous) {
      return Scaffold();
    } else {
      return Scaffold(
        body: Container(
          color: primaryColor,
          height: _height,
          width: _width,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _height * 0.025,
                ),
                showAlert(),
                SizedBox(
                  height: _height * 0.025,
                ),
                buildHeaderText(),
                SizedBox(
                  height: _height * 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: buildInputs() + buildButtons(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(_warning, maxLines: 2),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  AutoSizeText buildHeaderText() {
    String _headerText;

    if (authFormType == AuthFormType.signUp) {
      _headerText = 'Create New Account';
    } else if (authFormType == AuthFormType.reset) {
      _headerText = 'Reset Password';
    } else {
      _headerText = 'Sign In';
    }

    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        color: Colors.white,
      ),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    if (authFormType == AuthFormType.reset) {
      textFields.add(
        TextFormField(
          validator: EmailValidator.validate,
          style: TextStyle(
            fontSize: 16.0,
          ),
          decoration: buildSignUpInputDecoration('Email'),
          onSaved: (value) => _email = value,
        ),
      );
      textFields.add(SizedBox(height: 20.0));
      return textFields;
    }

    //if in signup state add email & password
    textFields.add(
      TextFormField(
        validator: EmailValidator.validate,
        style: TextStyle(
          fontSize: 16.0,
        ),
        decoration: buildSignUpInputDecoration('Email'),
        onSaved: (value) => _email = value,
      ),
    );
    textFields.add(SizedBox(
      height: 30.0,
    ));
    textFields.add(
      TextFormField(
        validator: PasswordValidator.validate,
        style: TextStyle(
          fontSize: 16.0,
        ),
        decoration: buildSignUpInputDecoration('Password'),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );

    textFields.add(SizedBox(
      height: 20.0,
    ));

    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white),
      contentPadding: const EdgeInsets.only(
        left: 14.0,
        bottom: 10.0,
        top: 10.0,
      ),
    );
  }

  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;
    bool _showPasswordReset = false;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = 'Create new account';
      _newFormState = 'signUp';
      _submitButtonText = 'Sign In';
      _showPasswordReset = true;
    } else if (authFormType == AuthFormType.reset) {
      _switchButtonText = 'Return to sign in';
      _newFormState = 'signIp';
      _submitButtonText = 'Submit';
    } else {
      _switchButtonText = 'Have an account? Sign in.';
      _newFormState = 'signIn';
      _submitButtonText = 'Sign Up';
    }

    return [
      Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: Colors.white,
            textColor: primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_submitButtonText,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                  )),
            ),
            onPressed: submit,
          )),
      showPasswordReset(_showPasswordReset),
      FlatButton(
        child: Text(
          _switchButtonText,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      )
    ];
  }

  Widget showPasswordReset(bool visible) {
    return Visibility(
      child: FlatButton(
        child: Text(
          'Forgot password?',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
      ),
      visible: visible,
    );
  }
}
