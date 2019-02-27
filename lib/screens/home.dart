import 'package:animation/widgets/cat.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  final Widget child;

  Home({Key key, this.child}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  Animation<double> boxAnimation;
  AnimationController boxController;

  void initState() {
    super.initState();

    catController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    catAnimation = Tween(begin: -50.0, end: -90.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));

    boxController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65)
        .animate(CurvedAnimation(parent: boxController, curve: Curves.easeInOut));
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    boxController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Animation!"),
        ),
        body: GestureDetector(
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                buildCatAnimation(),
                buildBox(),
                buildLeftFlap(),
                buildRightFlap(),
              ],
            ),
          ),
          onTap: onTap,
        ));
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      child: Cat(),
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          right: 0,
          left: 0,
          top: catAnimation.value,
          child: child,
        );
      },
    );
  }

  Widget buildBox() {
    return Container(
      height: 200,
      width: 240,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 9,
      top: 4,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 11,
          width: 110,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle: boxAnimation.value,
            child: child,
            alignment: Alignment.topLeft,
          );
        },
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 9,
      top: 4,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 11,
          width: 110,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle: -boxAnimation.value,
            child: child,
            alignment: Alignment.topRight,
          );
        },
      ),
    );
  }

  onTap() {
    if (catController.status == AnimationStatus.completed ||
        catController.status == AnimationStatus.forward) {
      catController.reverse();
      boxController.forward();
    } else if (catController.status == AnimationStatus.dismissed ||
        catController.status == AnimationStatus.reverse) {
      catController.forward();
      boxController.stop();
    }
  }
}
