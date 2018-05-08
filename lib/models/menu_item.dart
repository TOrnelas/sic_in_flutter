import 'package:flutter/material.dart';

class MenuItem{

  static num GEN_ID = 0;

  num id;
  String title;
  Widget widget;
  Icon icon;

  MenuItem(String title, Widget widget, Icon icon){
    this.id = GEN_ID;
    this.title = title;
    this.widget = widget;
    this.icon = icon;
    GEN_ID++;
  }
}