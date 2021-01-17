import 'package:awesome/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class WavePage extends StatefulWidget {
  @override
  _WavePageState createState() => _WavePageState();
}

class _WavePageState extends State<WavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Wave Animation',
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WaveContainer(
                width: double.infinity,
                height: 40,
                waveColor: Colors.orangeAccent),
            SizedBox(
              height: 200,
            ),
            RandomWaveContainer(
                width: double.infinity,
                height: 80,
                waveColor: Colors.red,
            duration: Duration(seconds: 100),),
          ],
        ),
      ),
    );
  }
}

class WaveContainer extends StatefulWidget {
  final Duration duration;
  final double height;
  final double width;
  final Color waveColor;

  const WaveContainer({
    Key key,
    this.duration,
    @required this.height,
    @required this.width,
    this.waveColor,
  }) : super(key: key);

  @override
  _WaveContainerState createState() => _WaveContainerState();
}

class _WaveContainerState extends State<WaveContainer>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Duration _duration;
  Color _waveColor;

  @override
  void initState() {
    super.initState();

    _duration = widget.duration ?? const Duration(milliseconds: 1000);
    _animationController = AnimationController(vsync: this, duration: _duration);
    _waveColor = widget.waveColor ?? Colors.lightBlueAccent;

    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return CustomPaint(
            painter: WavePainter(
                waveAnimation: _animationController, waveColor: _waveColor),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.stop();
    _animationController?.dispose();
    super.dispose();
  }
}

class WavePainter extends CustomPainter {
  Animation<double> waveAnimation;
  Color waveColor;

  WavePainter({this.waveAnimation, this.waveColor});

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    for (double i = 0.0; i < size.width; i++) {
      path.lineTo(i,
          sin((i / size.width * 2 * pi) + (waveAnimation.value * 2 * pi)) * 4);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    Paint wavePaint = Paint()..color = waveColor;
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class RandomWaveContainer extends StatefulWidget {
  final Duration duration;
  final double height;
  final double width;
  final Color waveColor;

  const RandomWaveContainer({
    Key key,
    this.duration,
    @required this.height,
    @required this.width,
    this.waveColor,
  }) : super(key: key);

  @override
  _RandomWaveContainerState createState() => _RandomWaveContainerState();
}

class _RandomWaveContainerState extends State<RandomWaveContainer>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Duration _duration;
  Color _waveColor;

  @override
  void initState() {
    super.initState();

    _duration = widget.duration ?? const Duration(seconds: 100);
    _animationController = AnimationController(
        vsync: this, duration: _duration, upperBound: pi * 2);
    _waveColor = widget.waveColor ?? Colors.lightBlueAccent;

    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return CustomPaint(
            painter: RandomWavePainter(
                waveAnimation: _animationController, waveColor: _waveColor),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.stop();
    _animationController?.dispose();
    super.dispose();
  }
}

class RandomWavePainter extends CustomPainter {
  Animation<double> waveAnimation;
  Color waveColor;

  RandomWavePainter({this.waveAnimation, this.waveColor});

  @override
  void paint(Canvas canvas, Size size) {
    Random r = Random();

    Path path = Path();

    for (double i = 0.0; i < size.width/3; i++) {
      int rInt = r.nextInt(4) + 1;
      path.lineTo(i, sin(i - waveAnimation.value) * size.height/rInt);
      //path.lineTo(i, sin(i / 4 - waveAnimation.value) * size.height/rInt);
    }
    for (double i = size.width/3; i < size.width*3/4; i++) {
      int rInt = r.nextInt(32) + 1;
      path.lineTo(i, sin(i - waveAnimation.value) * size.height/rInt);
      //path.lineTo(i, sin(i/8 - waveAnimation.value) * size.height/waveAnimation.value);
    }
    for (double i = size.width*3/4; i < size.width; i += 6) {
      int rInt = r.nextInt(4) + 1;
      path.lineTo(i, sin(i - waveAnimation.value) * size.height/rInt);
      //path.lineTo(i, sin(i/8 - waveAnimation.value) * size.height/waveAnimation.value);
    }
    path.moveTo(size.width, size.height);
    //path.lineTo(size.width, 0);
    //path.lineTo(0.0, size.height);


    path.close();

    Paint paint = Paint()..color = waveColor;
    paint.style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
