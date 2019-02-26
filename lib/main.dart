import 'package:flutter/material.dart';
import 'package:newfirebase/auth.dart';
import 'package:newfirebase/root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: RootPage(
        auth: Auth(),
      ),
    ));
  }
}
