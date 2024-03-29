import 'package:flutter/material.dart';
import 'package:topilocal_app/services/auth_service.dart';
import 'package:topilocal_app/views/landing_page.dart';
import 'package:topilocal_app/widgets/provider_widget.dart';
import 'package:topilocal_app/views/sign_up_view.dart';
import 'package:topilocal_app/views/navigation_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: 'Topilocal',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        // home: HomeController(), // with sign in anonymously
        home: SignUpView(
          authFormType: AuthFormType.signIn,
        ),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeController(),
          '/signUp': (BuildContext context) => SignUpView(
                authFormType: AuthFormType.signUp,
              ),
          '/signIn': (BuildContext context) => SignUpView(
                authFormType: AuthFormType.signIn,
              ),
          '/anonymousSignIn': (BuildContext context) => SignUpView(
                authFormType: AuthFormType.anonymous,
              ),
          '/convertUser': (BuildContext context) => SignUpView(
                authFormType: AuthFormType.convert,
              ),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          // return signedIn ? MyHome() : LandingPage(); //with sign in anonymously
          return signedIn ? MyHome() : SignUpView(
                authFormType: AuthFormType.signIn,
              );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
