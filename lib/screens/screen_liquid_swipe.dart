import 'package:awesome/constants/app.dart';
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
      color: Colors.blue,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 124.0,
                  backgroundImage: NetworkImage(
                    AppConfig.IMAGE_DEMO,
                  ),
                ),
                SizedBox(height: 24,),
                Text(
                  "Hi",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "It's Me",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
                Text(
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
                Text(
                  "Take a",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "look at",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
                Text(
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
                Text(
                  "Liked?",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Fork!",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
                Text(
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
