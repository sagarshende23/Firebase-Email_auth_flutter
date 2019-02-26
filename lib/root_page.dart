import 'package:flutter/material.dart';
import 'package:newfirebase/homePage.dart';
import 'login_page.dart';
import 'auth.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notsignIn, signIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notsignIn;

  void initState() {
    super.initState();
    widget.auth.currentUser().then((userID) {
      setState(() {
        authStatus = userID == null ? AuthStatus.notsignIn : AuthStatus.signIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notsignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notsignIn:
        return LoginPage(
          auth: widget.auth,
          onSignIn: _signedIn,
        );
      case AuthStatus.signIn:
        return HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
    return LoginPage(auth: widget.auth);
  }
}
