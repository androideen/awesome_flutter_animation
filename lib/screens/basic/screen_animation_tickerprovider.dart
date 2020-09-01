import 'package:awesome/widgets/appbar.dart';
import 'package:awesome/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationTickerProviderPage extends StatefulWidget {
  final String animationType;

  const AnimationTickerProviderPage({Key key, this.animationType})
      : super(key: key);

  @override
  _AnimationTickerProviderPageState createState() =>
      _AnimationTickerProviderPageState();
}

class _AnimationTickerProviderPageState
    extends State<AnimationTickerProviderPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorTweenAnimation;
  Animation<double> _animationDouble;
  final DecorationTween _decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: Colors.blue,
      border: Border.all(
        color: Colors.orange,
        style: BorderStyle.solid,
        width: 2.0,
      ),
      borderRadius: BorderRadius.zero,
      shape: BoxShape.rectangle,
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Colors.brown,
          blurRadius: 10.0,
          spreadRadius: 4.0,
        )
      ],
    ),
    end: BoxDecoration(
      color: Colors.orange,
      border: Border.all(
        color: Colors.blue,
        style: BorderStyle.solid,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(10.0),
      shape: BoxShape.rectangle,
      // No shadow.
    ),
  );
  final RelativeRectTween _relativeRectTween = RelativeRectTween(
    begin: RelativeRect.fromLTRB(0, 0, 0, 0),
    end: RelativeRect.fromLTRB(0, 0, 40, 0),
  );
  final Tween<double> _turnsTween = Tween<double>(
    begin: 1,
    end: 2,
  );
  bool _first = true;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _colorTweenAnimation = ColorTween(
      begin: Color.fromRGBO(255, 255, 255, 0),
      end: Colors.blueAccent,
    ).animate(_animationController);

    _animationDouble =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    super.initState();
  }

  Widget _animationWidget() {
    switch (widget.animationType) {
      case 'AnimatedModalBarrier':
        return Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text('Press Play to hide me'),
                AnimatedModalBarrier(
                  color: _colorTweenAnimation,
                  dismissible: false,
                )
              ],
            ),
          ),
        );
      case 'AnimatedSize':
        return Center(
          child: Container(
            color: Colors.blue,
            child: AnimatedSize(
              curve: Curves.easeIn,
              duration: Duration(seconds: 2),
              vsync: this,
              child: FlutterLogo(size: _first ? 200 : 100),
            ),
          ),
        );
      case 'DecoratedBoxTransition':
        return Center(
          child: DecoratedBoxTransition(
            position: DecorationPosition.background,
            decoration: _decorationTween.animate(_animationController),
            child: Container(
              child: Container(
                width: 200,
                height: 200,
                padding: const EdgeInsets.all(20),
                child: FlutterLogo(),
              ),
            ),
          ),
        );
      case 'FadeTransition':
        return Center(
          child: FadeTransition(
            opacity: _animationController,
            child: _animationChild(),
          ),
        );
      case 'PositionedTransition':
        return Center(
          child: Container(
            color: Colors.blueAccent,
            height: 200,
            width: 200,
            child: Stack(
              children: [
                PositionedTransition(
                  rect: _relativeRectTween.animate(_animationController),
                  child: Container(
                    child: Container(
                      width: 200,
                      height: 200,
                      padding: const EdgeInsets.all(20),
                      child: FlutterLogo(),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      case 'RotationTransition':
        return RotationTransition(
          turns: _turnsTween.animate(_animationController),
          child: Center(
            child: Container(
              width: 200,
              height: 200,
              padding: const EdgeInsets.all(20),
              child: FlutterLogo(),
            ),
          ),
        );
      case 'ScaleTransition':
        return Center(
          child: Container(
            width: 300,
            height: 300,
            color: Colors.blueAccent,
            child: ScaleTransition(
                scale: _animationDouble,
                alignment: Alignment.center,
                child: FlutterLogo(size: 60)),
          ),
        );
      case 'SizeTransition':
        return Center(
          child: Container(
            width: 300,
            child: SizeTransition(
              child: FlutterLogo(size: 300),
              sizeFactor: _animationDouble,
            ),
          ),
        );
      case 'SlideTransition':
        return Center(
          child: SlideTransition(
              child: _animationChild(),
              position: Tween<Offset>(
                begin: Offset(0, 0),
                end: Offset(-1, 0),
              ).animate(_animationController)),
        );
      case 'AnimatedBuilder':
        return AnimatedBuilder(
          animation: _animationController,
          child: Center(child: _animationChild()),
          builder: (BuildContext context, Widget child) {
            return Transform.rotate(
              angle: _animationController.value * 2.0 * math.pi,
              child: child,
            );
          },
        );
      case 'AnimatedWidget':
        return SpinningContainer(controller: _animationController);
    }
    return Center(
      child: Text('No animation'),
    );
  }

  Widget _animationParent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _animationWidget(),
        FlatButton(
            color: Colors.blue,
            onPressed: () {
              setState(() {
                switch (widget.animationType) {
                  default:
                    if (_first) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
                    _first = !_first;
                    break;
                }
              });
            },
            child: Text(
              'Play',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }

  Widget _animationChild() {
    return Card(
      child: Container(
        color: Colors.blueAccent,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 60),
            SizedBox(height: 24),
            Text(
              widget.animationType,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: widget.animationType),
      body: SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: _animationParent(),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
