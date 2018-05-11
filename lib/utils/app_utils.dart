import 'package:flutter/widgets.dart';

class AppUtils{

  static isLandscape(BuildContext context){
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static isPortrait(BuildContext context){
    return !isLandscape(context);
  }

  static getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}