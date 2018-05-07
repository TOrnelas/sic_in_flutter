import 'package:flutter/material.dart';
import '../utils/app_utils.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    if (AppUtils.isLandscape(context)){
        return new Text("home landscape");
    }else{
      return new Text("home portrait");
    }
  }
}
