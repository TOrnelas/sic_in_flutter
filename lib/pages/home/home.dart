import 'package:flutter/material.dart';
import '../../utils/app_utils.dart';
import 'home_header.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  var header;

  @override
  void initState() {

    super.initState();
    if (header == null) header = new HomeHeader();
  }

  @override
  Widget build(BuildContext context) {

    final bool isPortrait = AppUtils.isPortrait(context);

    return new ListView(
        scrollDirection: isPortrait ? Axis.vertical : Axis.horizontal,
        children: <Widget>[
          header
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    header.disposePlayer();
  }
}
