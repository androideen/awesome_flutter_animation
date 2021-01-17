import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_morph/morph.dart';
import 'package:path_morph/sampled_path_data.dart';

class PathMorphPage extends StatefulWidget {
  @override
  _PathMorphPageState createState() => _PathMorphPageState();
}

class _PathMorphPageState extends State<PathMorphPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  SampledPathData _data;

  Path arrowRightPath() {
    return Path()
      ..moveTo(50, 50)
      ..lineTo(250, 150)
      ..lineTo(50, 250)
      ..lineTo(50, 50);
  }
  Path arrowDownPath() {
    return Path()
      ..moveTo(50, 50)
      ..lineTo(250, 50)
      ..lineTo(150, 250)
      ..lineTo(50, 50);
  }


  @override
  void initState() {

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));

    _data = PathMorph.samplePaths(arrowRightPath(), arrowDownPath());
    PathMorph.generateAnimations(_controller, _data, (i,z) {
      setState((){
        _data.shiftedPoints[i] = z;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('path_morph'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: (){
            setState(() {
              _controller.isDismissed ? _controller.forward() : _controller.reverse();
            });
          },
          child: Container(
            color: Colors.blue,
            width: 300,
            height: 300,
            child: CustomPaint(painter: ArrowPainter(PathMorph.generatePath(_data))),
          ),
        ),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {

  Path _path;
  var _paint;

  ArrowPainter(this._path) {
    _paint = Paint();
    _paint.color = Color.fromRGBO(255, 255, 255, 1.0);
    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = 5.0;
  }

  @override
  void paint(Canvas canvas, Size size) => canvas.drawPath(_path, _paint);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}