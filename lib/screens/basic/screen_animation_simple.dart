import 'package:awesome/constants/app.dart';
import 'package:flutter/material.dart';
import 'package:awesome/widgets/appbar.dart';

class SimpleAnimation extends StatefulWidget {
  final String animationType;

  const SimpleAnimation({Key key, this.animationType}) : super(key: key);

  @override
  _SimpleAnimationState createState() => _SimpleAnimationState();
}

class _SimpleAnimationState extends State<SimpleAnimation> {
  AlignmentGeometry _alignment = Alignment.topRight;
  bool _first = true;

  //for list
  List<String> _listData = [
    'Apple',
    'Watermelon',
    'Orange',
    'Pear',
    'Cherry',
    'Strawberry'
  ];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  Widget _animationWidget() {
    switch (widget.animationType) {
      case 'AnimatedAlign':
        return AnimatedAlign(
          alignment: _alignment,
          duration: Duration(seconds: 2),
          curve: Curves.ease,
          child: _animationChild(),
        );
      case 'AnimatedContainer':
        return Center(
          child: AnimatedContainer(
            width: _first ? 200.0 : 100.0,
            height: _first ? 100.0 : 200.0,
            color: _first ? Colors.blue : Colors.orange,
            alignment:
                _first ? Alignment.center : AlignmentDirectional.topCenter,
            duration: Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: FlutterLogo(
              size: 60,
            ),
          ),
        );
      case 'AnimatedCrossFade':
        return Center(
          child: SizedBox(
            width: 200,
            child: Card(
              child: Center(
                child: AnimatedCrossFade(
                  duration: Duration(seconds: 2),
                  firstChild: FlutterLogo(
                      style: FlutterLogoStyle.horizontal, size: 100.0),
                  secondChild:
                      FlutterLogo(style: FlutterLogoStyle.stacked, size: 100.0),
                  crossFadeState: _first
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstCurve: Curves.easeOutExpo,
                  secondCurve: Curves.easeInCubic,
                ),
              ),
            ),
          ),
        );
      case 'AnimatedDefaultTextStyle':
        return AnimatedDefaultTextStyle(
          duration: Duration(seconds: 2),
          style: _first
              ? TextStyle(color: Colors.red, fontSize: 24)
              : TextStyle(color: Colors.blue, fontSize: 16),
          child: Center(
              child: Text(
            'My text style',
          )),
        );
      case 'AnimatedListState':
        return SizedBox(
          height: 400,
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _listData.length,
            scrollDirection: Axis.vertical,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return SizeTransition(
                key: ValueKey<int>(index),
                sizeFactor: animation,
                child: SizedBox(
                  child: _card(index),
                ),
              );
            },
          ),
        );
      case 'AnimatedOpacity':
        return Center(
          child: AnimatedOpacity(
            opacity: _first ? 1.0 : 0.0,
            duration: Duration(seconds: 2),
            child: _animationChild(),
          ),
        );
      case 'AnimatedPhysicalModel ':
        return Center(
          child: AnimatedPhysicalModel(
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            elevation: _first ? 0 : 10.0,
            shape: BoxShape.rectangle,
            shadowColor: Colors.black,
            color: Colors.white,
            borderRadius: _first
                ? BorderRadius.all(Radius.circular(0))
                : BorderRadius.all(Radius.circular(16)),
            child: Container(
              height: 200.0,
              width: 200.0,
              color: Colors.blue[50],
              child: _animationChild(),
            ),
          ),
        );
      case 'AnimatedPositioned':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    left: _first ? 10 : 20,
                    top: _first ? 50 : 20,
                    right: _first ? 10 : 20,
                    bottom: _first ? 50 : 20,
                    child: Container(
                      color: Colors.blue,
                      child: Center(child: Text('AnimatedPositioned', style: TextStyle(color: Colors.white),)),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      case 'Hero':
        return Hero(
          tag: "hero-image",
          child: Container(
            width: double.infinity,
            height: 400.0,
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              maxRadius: 124.0,
              backgroundImage: NetworkImage(
                AppConfig.IMAGE_DEMO,
              ),
            ),
          ),
        );
    }
    return Center(
      child: Text('No selected animation'),
    );
  }

  Widget _animationParent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _animationWidget(),
        SizedBox(height: 24),
        FlatButton(
            color: Colors.blue,
            onPressed: () {
              setState(() {
                switch (widget.animationType) {
                  case 'AnimatedAlign':
                    _alignment = _alignment == Alignment.topRight
                        ? Alignment.topLeft
                        : Alignment.topRight;
                    break;
                  case 'AnimatedListState':
                    int listIndex = 0;
                    if (_first) {
                      _listData.insert(
                          listIndex, "New Fruit ${_listData.length + 1}");
                      _listKey.currentState.insertItem(listIndex);
                    } else {
                      AnimatedListRemovedItemBuilder builder =
                          (context, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-1, 0),
                            end: Offset(0, 0),
                          ).animate(animation),
                          child: SizedBox(
                            child: _card(listIndex),
                          ),
                        );
                      };
                      _listKey.currentState.removeItem(listIndex, builder);
                      _listData.removeAt(listIndex);
                    }

                    _first = !_first;
                    break;
                  default:
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
      color: Colors.blue,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FlutterLogo(size: 60),
            SizedBox(height: 24),
            Text(widget.animationType, style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }

  Widget _card(int index) {
    return Card(
      color: Colors.blue,
      child: ListTile(
        title: Text(
          _listData[index],
          style: TextStyle(color: Colors.white),
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
}
