import 'package:flutter/material.dart';
import 'home_header.dart';
import 'home_footer.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {

    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {

    return new ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          new HomeHeader(),
          new HomeFooter()
    ]);
  }
}