import 'package:animated_widgets/animated_widgets.dart';
import 'package:awesome/widgets/appbar.dart';
import 'package:awesome/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AnimatedWidgetsPage extends StatefulWidget {
  @override
  _AnimatedWidgetsPageState createState() => _AnimatedWidgetsPageState();
}

class _AnimatedWidgetsPageState extends State<AnimatedWidgetsPage> {
  bool _play = false;
  String fbtnText = '>>';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'animated_widgets'),
      floatingActionButton: FloatingActionButton(
        child: Text(fbtnText),
        onPressed: () {
          setState(() {
            _play = !_play;
            fbtnText = !_play ? '>>' : '<<';
          });
        },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                width: 320,
                child: Column(
                  children: [
                    TranslationAnimatedWidget(
                        enabled: _play,
                        values: [Offset(0, 0), Offset(-100, 0)],
                        child: Text('Translation', style: TextStyle(fontSize: 24.0),)),
                    SizedBox(height: 24),
                    RotationAnimatedWidget.tween(
                        rotationDisabled:
                            _play ? Rotation.deg(z: 0) : Rotation.deg(z: 90),
                        rotationEnabled:
                            _play ? Rotation.deg(z: 90) : Rotation.deg(z: 0),
                        child: Text('Rotation', style: TextStyle(fontSize: 24.0))),
                    SizedBox(height: 24),
                    OpacityAnimatedWidget.tween(
                        opacityEnabled: 1, //define start value
                        opacityDisabled: 0.5, //and end value
                        enabled: _play, //bind with the boolean
                        child: Text('Opacity', style: TextStyle(fontSize: 24.0))),
                    SizedBox(height: 24),
                    SizeAnimatedWidget(
                      enabled: _play,
                      duration: Duration(milliseconds: 1000),
                      values: [
                        Size(100, 100),
                        Size(100, 150),
                        Size(200, 150),
                        Size(200, 200)
                      ],
                      curve: Curves.linear,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue)
                          ),
                          child: Center(child: Text('Size', style: TextStyle(fontSize: 24.0)))
                      ),
                    ),
                    SizedBox(height: 24),
                    ShakeAnimatedWidget(
                      enabled: _play,
                      duration: Duration(milliseconds: 1500),
                      shakeAngle: Rotation.deg(z: 40),
                      curve: Curves.linear,
                      child: Text('Shake', style: TextStyle(fontSize: 24.0)),
                    ),
                    SizedBox(height: 24),
                    CustomAnimatedWidget(
                      enabled: _play,
                      duration: Duration(seconds: 3),
                      curve: Curves.easeOut,
                      builder: (context, percent) { //for custom animation, use builders
                        final int displayedDate = (2020 * percent).floor();
                        return Text(
                          "Custom - Current year : $displayedDate",
                          style: TextStyle(color: Colors.blue, fontSize: 24.0),
                        );
                      },
                    ),
                    TranslationAnimatedWidget.tween(
                      enabled: _play,
                      translationDisabled: Offset(-100, 0),
                      translationEnabled: Offset.zero,
                      child:
                      OpacityAnimatedWidget.tween(
                          enabled: _play,
                          opacityDisabled: 0,
                          opacityEnabled: 1,
                          child: ShakeAnimatedWidget(
                            enabled: _play,
                            duration: Duration(milliseconds: 1500),
                            shakeAngle: Rotation.deg(z: 40),
                            curve: Curves.linear,
                            child: Text('Translation + Opacity + Shake', style: TextStyle(fontSize: 24.0)),
                          )/* your widget */
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
