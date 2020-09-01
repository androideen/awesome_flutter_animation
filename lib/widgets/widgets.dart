import 'package:awesome/constants/app.dart';
import 'file:///J:/AndroidStudioProjects/awesome/lib/screens/basic/screen_animation_simple.dart';
import 'file:///J:/AndroidStudioProjects/awesome/lib/screens/basic/screen_animation_tickerprovider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Header extends StatelessWidget {
  final String text;

  const Header({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 24),
          )
        ],
      ),
    );
  }
}

class SubHeader extends StatelessWidget {
  final String text;

  const SubHeader({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.blueGrey),
          )
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String type;

  const ActionButton({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SimpleAnimation(
                    animationType: type,
                  )),
        );
      },
      child: Text(type, style: TextStyle(color: Colors.white)),
      color: Colors.blue,
    );
  }
}

class ActionButton2 extends StatelessWidget {
  final String type;

  const ActionButton2({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AnimationTickerProviderPage(
                    animationType: type,
                  )),
        );
      },
      child: Text(type, style: TextStyle(color: Colors.white)),
      color: Colors.blueAccent,
    );
  }
}

class HeroActionButton extends StatelessWidget {
  final String type;

  const HeroActionButton({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SimpleAnimation(
                    animationType: type,
                  )),
        );
      },
      child: Container(
        width: 100,
        child: Row(
          children: [
            Hero(
                tag: "hero-image",
                child: CircleAvatar(
                  maxRadius: 16.0,
                  backgroundImage: NetworkImage(
                    AppConfig.IMAGE_DEMO,
                  ),
                )),
            SizedBox(
              width: 24,
            ),
            Text('Hero', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      color: Colors.blue,
    );
  }
}

class SpinningContainer extends AnimatedWidget {
  const SpinningContainer({Key key, AnimationController controller})
      : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _progress.value * 2.0 * math.pi,
      child: Center(
        child: Container(
          width: 300.0,
          height: 300.0,
          color: Colors.blueAccent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(
                  size: 200,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'SpinningContainer extends AnimatedWidget',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
