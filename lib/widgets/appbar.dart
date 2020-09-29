import 'package:awesome/constants/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MainAppBar extends StatelessWidget with PreferredSizeWidget{
  final double barHeight = 0;
  final String title;

  MainAppBar({Key key, this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + barHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
          //Icon(Icons.dehaze)
      ],
    );
  }

}
