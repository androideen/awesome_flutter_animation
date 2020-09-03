import 'package:awesome/widgets/appbar.dart';
import 'package:awesome/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class LiquidSwipePage extends StatefulWidget {
  @override
  _LiquidSwipePageState createState() => _LiquidSwipePageState();
}

class _LiquidSwipePageState extends State<LiquidSwipePage> {
  final pages = [
    Container(
      color: Colors.pink,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Column(
              children: <Widget>[
                new Text(
                  "Hi",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
                new Text(
                  "It's Me",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
                new Text(
                  "Sahdeep",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    Container(
      color: Colors.deepPurpleAccent,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                new Text(
                  "Take a",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
                new Text(
                  "look at",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
                new Text(
                  "Liquid Swipe",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    Container(
      color: Colors.greenAccent,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                new Text(
                  "Liked?",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
                new Text(
                  "Fork!",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
                new Text(
                  "Give Star!",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(title: 'liquid_swipe'),
        body: LiquidSwipe(
          pages: pages,
          fullTransitionValue: 500,
          enableSlideIcon: true,
        ));
  }
}
