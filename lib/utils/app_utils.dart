import 'package:flutter/widgets.dart';

class AppUtils{

  static isLandscape(BuildContext context){
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static isPortrait(BuildContext context){
    return !isLandscape(context);
  }
}