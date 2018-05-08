import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/epg.dart';
import 'models/menu_item.dart';

class App extends StatefulWidget {

  App({Key key, this.title}) : super(key: key);

  final String title;

  final items = <MenuItem>[
    new MenuItem("Home", Home(), new Icon(Icons.home)),
    new MenuItem("EPG", Epg(), new Icon(Icons.grid_on))
  ];

  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {

  var selectedMenuPosition = 0;
  
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(child: _getPageForSelectedIndex()),
      drawer: new Drawer(
        child: ListView(
          children: _generateDrawerWidgets(),
        ),
      ),
    );
  }

  _select(int menuItemPosition){

    selectedMenuPosition = menuItemPosition;
    setState(() => {});
    if(Navigator.of(context).canPop())
      Navigator.of(context).pop();
  }

  _getPageForSelectedIndex(){

    if(widget.items[selectedMenuPosition].widget != null)
      return widget.items[selectedMenuPosition].widget;
  }

  _generateDrawerWidgets(){

    var drawerItems = <Widget>[];

    //add header
    drawerItems.add(new DrawerHeader(child: new Center(child: new Image.network("http://i.imgur.com/ioMrqvL.png", height: 100.0))));

    //add menus
    for (var i = 0; i < widget.items.length; i++){

      final menuItem = widget.items[i];
      drawerItems.add(
          new ListTile(
            leading: new Center(child: menuItem.icon),
            title: new Text(menuItem.title),
            onTap: () => _select(i), selected: i == selectedMenuPosition)
      );
    }

    return drawerItems;
  }
}