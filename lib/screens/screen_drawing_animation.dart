import 'package:flutter/material.dart';
import 'package:drawing_animation/drawing_animation.dart';

class DrawingAnimationPage extends StatefulWidget {
  @override
  _DrawingAnimationPageState createState() => _DrawingAnimationPageState();
}

class _DrawingAnimationPageState extends State<DrawingAnimationPage> {
  bool _run = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('drawing_animation'),
      ),
      body: Center(
        child: AnimatedDrawing.svg(
          "assets/potion.svg",
          run: _run,
          duration: new Duration(seconds: 3),
          onFinish: () => setState(() {
            _run = false;
          }),
        ),
      ),
    );
  }
}
