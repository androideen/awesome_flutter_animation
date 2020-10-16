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
                height: 300,
                color: Colors.orangeAccent),

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
  final Color color;

  const WaveContainer({
    Key key,
    this.duration,
    @required this.height,
    @required this.width,
    this.color,
  }) : super(key: key);

  @override
  _WaveContainerState createState() => _WaveContainerState();
}

class _WaveContainerState extends State<WaveContainer>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Duration _duration;
  Color _color;

  @override
  void initState() {
    super.initState();

    _duration = widget.duration ?? const Duration(milliseconds: 1000);
    _animationController = AnimationController(vsync: this, duration: _duration);
    _color = widget.color ?? Colors.orange;

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
                waveAnimation: _animationController, color: _color),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
}

class WavePainter extends CustomPainter {
  Animation<double> waveAnimation;
  Color color;

  WavePainter({this.waveAnimation, this.color});

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

    Paint wavePaint = Paint()..color = color;
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
