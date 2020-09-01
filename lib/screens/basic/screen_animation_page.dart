import 'package:awesome/constants/app.dart';
import 'package:flutter/material.dart';
import 'package:awesome/widgets/appbar.dart';

class PageAnimation extends StatefulWidget {
  final String animationType;

  const PageAnimation({Key key, this.animationType}) : super(key: key);

  @override
  _PageAnimationState createState() => _PageAnimationState();
}

class _PageAnimationState extends State<PageAnimation> {


  Widget _animationWidget() {
    return Center(
      child: Text(widget.animationType, style: TextStyle(fontSize: 48.0, color: Colors.white),),
    );
  }

  Widget _animationParent() {
    return Container(
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _animationWidget(),
          SizedBox(height: 24),
          FlatButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Go Back',
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: widget.animationType),
      body: SafeArea(
        child: _animationParent(),
      ),
    );
  }
}
