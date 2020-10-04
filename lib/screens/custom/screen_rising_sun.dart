import 'package:animated_widgets/animated_widgets.dart';
import 'package:awesome/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CityMorningPage extends StatefulWidget {
  @override
  _CityMorningPageState createState() => _CityMorningPageState();
}

class _CityMorningPageState extends State<CityMorningPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controllerAfter;
  Animation<double> _sunSize;
  Animation<double> _sunPosition;
  Animation<double> _sunOpacity;
  Animation<double> _cloudOpacity;
  Animation<double> _cityOpacity;
  Animation<double> _cityShadowOpacity;
  Animation<double> _skyOpacity;
  Animation<double> _carPosition;
  Animation<double> _carLight;
  bool _completed = false;
  Duration _duration = Duration(seconds: 3);
  Duration _durationAfter = Duration(seconds: 5);

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _duration);
    _controllerAfter =
        AnimationController(vsync: this, duration: _durationAfter);

    //sun
    _sunSize = Tween(begin: 96.0, end: 72.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 0.75, curve: Curves.ease),
      ),
    );
    _sunPosition = Tween(begin: 250.0, end: 100.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1, curve: Curves.ease),
      ),
    );
    _sunOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 0.75, curve: Curves.ease),
      ),
    );
    //cloud
    _cloudOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.75, 1, curve: Curves.ease),
      ),
    );
    //sky
    _skyOpacity = Tween(begin: 0.75, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.25, 0.75, curve: Curves.ease),
      ),
    );
    //city
    _cityOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.25, 0.75, curve: Curves.ease),
      ),
    );
    //city - shadow
    _cityShadowOpacity = Tween(begin: 0.0, end: 0.25).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1, curve: Curves.ease),
      ),
    );

    //car
    _carPosition = Tween(begin: -100.0, end: 500.0).animate(
      CurvedAnimation(
        parent: _controllerAfter,
        curve: Interval(0.0, 1, curve: Curves.ease),
      ),
    );
    _carLight = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controllerAfter,
        curve: Interval(0.0, 0.4, curve: Curves.ease),
      ),
    );

    _controller.addStatusListener((status) {
      if (AnimationStatus.completed == status) {
        _completed = true;
        //setState after completing to display Floating Button
        setState(() {});
      } else {
        _completed = false;
      }
    });
    _controller.forward();
    _controllerAfter.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'Morning in the City'),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Opacity(
                  opacity: _skyOpacity.value,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                top: _sunPosition.value,
                left: MediaQuery.of(context).size.width / 2 - _sunSize.value / 2,
                child: Opacity(
                  opacity: _sunOpacity.value,
                  child: Icon(
                    Icons.wb_sunny,
                    size: _sunSize.value,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
              Positioned(
                  top: 140,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: Opacity(
                      opacity: _cloudOpacity.value,
                      child: Container(
                        width: 200,
                        height: 100,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Icon(
                                Icons.cloud,
                                size: 48.0,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 70,
                              child: Icon(
                                Icons.cloud,
                                size: 48.0,
                                color: Colors.blue,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 50,
                              child: Icon(
                                Icons.cloud,
                                size: 48.0,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ))),
              Positioned(
                  top: 250,
                  left: MediaQuery.of(context).size.width / 2 - 32,
                  child: Opacity(
                    opacity: _cityOpacity.value,
                    child: Icon(
                      Icons.home,
                      size: 72,
                      color: Colors.red,
                    ),
                  )),
              Positioned(
                  top: 298,
                  left: MediaQuery.of(context).size.width / 2 - 32,
                  child: Transform(
                    transform: Matrix4.skewX(1 - _controller.value),
                    child: Opacity(
                      opacity: _cityShadowOpacity.value,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationX(math.pi),
                        child: Icon(
                          Icons.home,
                          size: 72,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )),
              Positioned(
                bottom: 100,
                left: 0,
                child: Opacity(
                  opacity: _cityOpacity.value,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.home,
                          size: 72,
                          color: Colors.blueGrey,
                        ),
                        Icon(
                          Icons.account_balance,
                          size: 72,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.business,
                          size: 72,
                          color: Colors.lightGreen,
                        ),
                        Icon(
                          Icons.apartment,
                          size: 72,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 0,
                child: Transform.translate(
                  offset: Offset(_carPosition.value, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.airport_shuttle,
                        size: 48,
                        color: Colors.red,
                      ),
                      Opacity(
                        opacity: _carLight.value,
                        child: Container(
                          width: 30,
                          height: 3,
                          color: Colors.yellow,
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ],
          );
        },
      ),
      floatingActionButton: _completed
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CityMorningPage()),
                );
              },
              child: Icon(Icons.refresh),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerAfter.dispose();
    super.dispose();
  }
}
