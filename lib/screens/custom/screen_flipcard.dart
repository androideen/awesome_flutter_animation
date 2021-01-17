import 'dart:math';

import 'package:flutter/material.dart';

class FlipCardPage extends StatefulWidget {
  @override
  _FlipCardPageState createState() => _FlipCardPageState();
}

class _FlipCardPageState extends State<FlipCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flip Animation'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlipCard(),
          ],
        ),
      ),
    );
  }
}

class FlipCard extends StatefulWidget {
  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
  }

  Widget _frontCard() {
    return Container(
      key: ValueKey(true),
      color: Colors.orangeAccent,
      width: 200,
      height: 200,
      child: Center(
          child: Text(
        'Front',
        style: TextStyle(color: Colors.white, fontSize: 48),
      )),
    );
  }

  Widget _rearCard() {
    return Container(
      key: ValueKey(false),
      color: Colors.orange,
      width: 200,
      height: 200,
      child: Center(
          child: Text(
        'Rear',
        style: TextStyle(color: Colors.white, fontSize: 48),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFront = !_isFront;
        });
      },
      child: AnimatedSwitcher(
        child: _isFront ? _frontCard() : _rearCard(),
        duration: Duration(seconds: 1),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final rotate = Tween(begin: pi, end: 0.0).animate(animation);

          return AnimatedBuilder(
              animation: rotate,
              child: child,
              builder: (BuildContext context, Widget child) {
                final angle = (ValueKey(_isFront) != widget.key)
                    ? min(rotate.value, pi / 2)
                    : rotate.value;
                return Transform(
                  transform: Matrix4.rotationY(angle),
                  child: child,
                  alignment: Alignment.center,
                );
              });
        },
        switchInCurve: Curves.easeInCubic,
        switchOutCurve: Curves.easeOutCubic,
      ),
    );
  }
}
