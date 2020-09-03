import 'package:awesome/screens/simple_animations/acx_progress_indicator.dart';
import 'package:awesome/screens/simple_animations/bar_chart.dart';
import 'package:awesome/screens/simple_animations/fade_in_ui.dart';
import 'package:awesome/screens/simple_animations/fancy_background.dart';
import 'package:awesome/screens/simple_animations/hit_a_mole.dart';
import 'package:awesome/screens/simple_animations/load_stuff_button.dart';
import 'package:awesome/screens/simple_animations/particle_background.dart';
import 'package:awesome/screens/simple_animations/rainbow_circle.dart';
import 'package:awesome/screens/simple_animations/rectangle.dart';
import 'package:awesome/screens/simple_animations/switchlike_checkbox.dart';
import 'package:awesome/screens/simple_animations/typewriter_box.dart';
import 'package:awesome/widgets/appbar.dart';
import 'package:awesome/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:url_launcher/url_launcher.dart';

enum AniProps { width, height, color }

class SimpleAnimationsPage extends StatefulWidget {
  @override
  _SimpleAnimationsPageState createState() => _SimpleAnimationsPageState();
}

class _SimpleAnimationsPageState extends State<SimpleAnimationsPage> {
  FlatButton _sampleButton(
      BuildContext context, String library, WidgetBuilder builder) {
    return FlatButton(
      minWidth: 240.0,
        color: Colors.blue,
        child: Text(library, style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: builder),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(title: 'simple_animations'),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  width: 320,
                  child: Column(
                    children: [
                      _sampleButton(context, 'ProgressIndicatorAnimation',
                          (context) => AcxProgressIndicatorDemo()),
                      _sampleButton(context, 'BarChartApplication',
                          (context) => BarChartDemo()),
                      _sampleButton(
                          context, 'FadeInUi', (context) => FadeInUiDemo()),
                      _sampleButton(context, 'FancyBackground',
                          (context) => FancyBackgroundDemo()),
                      _sampleButton(
                          context, 'HitAMole', (context) => HitAMoleDemo()),
                      _sampleButton(
                          context, 'LoadStuffButton', (context) => LoadStuffButtonDemo()),
                      _sampleButton(
                          context, 'ParticleBackground', (context) => ParticleBackgroundDemo()),
                      _sampleButton(
                          context, 'RainbowCircle', (context) => RainbowCircleDemo()),
                      _sampleButton(
                          context, 'ExampleRectangle', (context) => ExampleRectangle()),
                      _sampleButton(
                          context, 'SwitchlikeCheckbox', (context) => SwitchlikeCheckboxDemo()),
                      _sampleButton(
                          context, 'TypewriterBox', (context) => TypewriterBoxDemo()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class ExamplePage extends StatefulWidget {
  final String title;
  final String pathToFile;
  final WidgetBuilder builder;
  final bool delayStartup;

  ExamplePage(
      {this.title, this.pathToFile, this.builder, this.delayStartup = false})
      : assert(!pathToFile.contains("-"),
            "Don't use minus character in filenames.");

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  var renderBuilder = true;

  @override
  void initState() {
    if (widget.delayStartup) {
      renderBuilder = false;
      Future.delayed(Duration(milliseconds: 500)).then((_) {
        setState(() => renderBuilder = true);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: widget.title,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _buildPage(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    if (!renderBuilder) {
      return Container();
    }
    return this.widget.builder(context);
  }
}
