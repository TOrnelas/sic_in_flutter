import 'package:flutter/material.dart';
import '../../utils/app_utils.dart';
import 'home_header.dart';
import 'home_footer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new ListView(
        scrollDirection: /*isPortrait ? */Axis.vertical/* : Axis.horizontal*/,
        children: <Widget>[
          new HomeHeader(),
          new HomeFooter()
    ]);
  }
}