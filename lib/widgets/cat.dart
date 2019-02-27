import 'package:flutter/material.dart';

class Cat extends StatelessWidget {
  final Widget child;

  Cat({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network("https://i.imgur.com/QwhZRyL.png");
  }
}
