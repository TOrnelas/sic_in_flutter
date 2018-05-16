import 'package:flutter/widgets.dart';
import '../resources/strings.dart';

class AppUtils{

  static isLandscape(BuildContext context){
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static isPortrait(BuildContext context){
    return !isLandscape(context);
  }

  static isTablet(BuildContext context){
    return ;
  }

  static getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static getDeviceLanguage(BuildContext context){
    return Localizations.localeOf(context).languageCode;
  }

  static getDeviceCountry(BuildContext context){
    return Localizations.localeOf(context).countryCode;
  }

  static getStringForLanguage(BuildContext context, String key){
    return Strings.localizedStrings[getDeviceLanguage(context)][key];
  }
}