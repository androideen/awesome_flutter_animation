import 'package:awesome/constants/app.dart';
import 'package:flutter/material.dart';
import 'package:awesome/widgets/appbar.dart';

class StackedMenuPage extends StatefulWidget {
  @override
  _StackedMenuPageState createState() => _StackedMenuPageState();
}

class _StackedMenuPageState extends State<StackedMenuPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  void stack() {
    setState(() {
      _controller.isDismissed ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        double slide = 50 * _controller.value;
        double scale = 1 - (_controller.value * 0.5);
        return Stack(
          children: [
            Container(
              width: double.infinity,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Menu', style: TextStyle(fontSize: 24.0),),
                          FlatButton(onPressed: (){}, child: Text('Menu 1')),
                          FlatButton(onPressed: (){}, child: Text('Menu 2')),
                          FlatButton(onPressed: (){}, child: Text('Menu 3')),
                          FlatButton(onPressed: (){}, child: Text('Menu 4')),
                          FlatButton(onPressed: () => stack(), child: Text('Close')),
                        ],
                      ),
                      flex: 5,
                    ),
                    Expanded(
                      child: Container(),
                      flex: 5,
                    )
                  ],
                ),
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(slide)
                ..scale(scale),
              alignment: Alignment.centerRight,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Stacked Menu'),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.dehaze),
                      onPressed: () {
                        stack();
                      },
                    )
                  ],
                ),
                body: Container(),
              ),
            ),
          ],
        );
      },
    );

  }
}
