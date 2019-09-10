import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:topilocal_app/widgets/custom_dialog.dart';

class LandingPage extends StatelessWidget {
  final primaryColor = const Color(0xFF7851a9);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _height * 0.1,
                ),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 44,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: _height * 0.1,
                ),
                AutoSizeText(
                  'Topilocal. It\'s logical.',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: _height * 0.1,
                ),
                RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                        title: 'Create an account!',
                        description:
                            'With an account, you have the ability to save your information and search and find local jobs',
                        primaryButtonText: 'Create My Account',
                        primaryButtonRoute: '/signUp',
                        secondaryButtonText: 'Maybe Later',
                        secondaryButtonRoute: '/home',
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: _height * 0.05,
                ),
                FlatButton(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/signIn');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
