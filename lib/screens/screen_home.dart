import 'package:awesome/constants/app.dart';
import 'package:awesome/screens/basic/screen_animation_page.dart';
import 'package:awesome/screens/screen_animated_widgets.dart';
import 'package:awesome/screens/screen_liquid_swipe.dart';

import 'package:awesome/screens/screen_simple_animation.dart';
import 'package:awesome/widgets/widgets.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:awesome/widgets/appbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _bottomNavIndex = 0;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MainAppBar(
        title: AppConfig.APP_NAME,
      ),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.widgets, title: 'Widget'),
          TabItem(icon: Icons.library_books, title: 'Page'),
          TabItem(icon: Icons.extension, title: 'Library'),
          TabItem(icon: Icons.work, title: 'Custom')
        ],
        onTap: (int i) => setState(() => _bottomNavIndex = i),
        style: TabStyle.reactCircle,
      ),
      body: SafeArea(
          minimum: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              child: IndexedStack(
            index: _bottomNavIndex,
            children: [
              _page([
                Header(text: 'Animation Widget'),
                ActionButton(type: 'AnimatedAlign'),
                ActionButton(type: 'AnimatedContainer'),
                ActionButton(type: 'AnimatedCrossFade'),
                ActionButton(type: 'AnimatedDefaultTextStyle'),
                ActionButton(type: 'AnimatedListState'),
                ActionButton(type: 'AnimatedOpacity'),
                ActionButton(type: 'AnimatedPhysicalModel'),
                ActionButton(type: 'AnimatedPositioned'),
                HeroActionButton(
                  type: 'Hero',
                ),
                SubHeader(text: 'with AnimationController'),
                ActionButton2(type: 'AnimatedModalBarrier'),
                ActionButton2(type: 'AnimatedSize'),
                ActionButton2(type: 'DecoratedBoxTransition'),
                ActionButton2(type: 'FadeTransition'),
                ActionButton2(type: 'PositionedTransition'),
                ActionButton2(type: 'RotationTransition'),
                ActionButton2(type: 'ScaleTransition'),
                ActionButton2(type: 'SizeTransition'),
                ActionButton2(type: 'SlideTransition'),
                ActionButton2(type: 'AnimatedBuilder'),
                ActionButton2(type: 'AnimatedWidget'),
              ]),
              _page([
                Header(text: 'Page Transition'),
                _pageAnimationButton(context, 'Slide From Edge', 'slide'),
                _pageAnimationButton(
                    context, 'Slide From Left To Right', 'slide_left_to_right'),
                _pageAnimationButton(context, 'Fade', 'fade'),
                _pageAnimationButton(context, 'Scale', 'scale'),
                _pageAnimationButton(context, 'Size', 'size'),
                _pageAnimationButton(context, 'Rotate', 'rotate'),
              ]),
              _page([
                Header(text: '3rd-party Libraries'),
                _libraryAnimationButton(context, 'animated_widgets',
                    (context) => AnimatedWidgetsPage()),
                _libraryAnimationButton(
                    context, 'liquid_swipe', (context) => LiquidSwipePage()),
                _libraryAnimationButton(context, 'simple_animations',
                    (context) => SimpleAnimationsPage()),
              ]),
              _page([
                Header(text: 'Custom Animations'),
              ]),
            ],
          ))),
    );
  }

  Container _page(List<Widget> children) {
    return Container(
      child: Wrap(
        spacing: 3,
        children: children,
      ),
    );
  }

  FlatButton _libraryAnimationButton(
      BuildContext context, String library, WidgetBuilder builder) {
    return FlatButton(
        color: Colors.green,
        child: Text(library, style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: builder),
          );
        });
  }

  FlatButton _pageAnimationButton(
      BuildContext context, String text, String animationType) {
    return FlatButton(
        color: Colors.blueGrey,
        child: Text(text, style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                PageAnimation(animationType: text),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              switch (animationType) {
                case 'slide':
                  return SlideTransition(
                    position: animation.drive(
                        Tween(begin: Offset(-1.0, 1.0), end: Offset.zero)
                            .chain(CurveTween(curve: Curves.easeInCubic))),
                    child: child,
                  );
                case 'slide_left_to_right':
                  return SlideTransition(
                    position: animation.drive(
                        Tween(begin: Offset(-1.0, 0.0), end: Offset.zero)),
                    child: child,
                  );
                case 'fade':
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                case 'scale':
                  return ScaleTransition(
                      child: child,
                      scale: Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.fastOutSlowIn,
                        ),
                      ));
                case 'size':
                  return Align(
                    child: SizeTransition(
                      sizeFactor: animation,
                      child: child,
                    ),
                  );
                case 'rotate':
                  return RotationTransition(
                      child: child,
                      turns: Tween<double>(
                        begin: 1,
                        end: 2,
                      ).animate(animation));
              }

              //default animation
              return SlideTransition(
                position: animation
                    .drive(Tween(begin: Offset(0.0, 1.0), end: Offset.zero)),
                child: child,
              );
            },
          ));
        });
  }
}
