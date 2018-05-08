import 'package:flutter/material.dart';
import '../utils/app_utils.dart';

class Epg extends StatefulWidget {
  @override
  _EpgState createState() => new _EpgState();
}

class _EpgState extends State<Epg> {
  @override
  Widget build(BuildContext context) {
    if(AppUtils.isLandscape(context)){
      return new Text("Landscape EPG");
    }else{
      return new Text("Portrait EPG");
    }
  }
}
