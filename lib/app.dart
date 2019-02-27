import 'package:animation/screens/home.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final Widget child;

  App({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "animation",
      theme: ThemeData(primarySwatch: Colors.green),
      home: Home(),
    );
  }
}
