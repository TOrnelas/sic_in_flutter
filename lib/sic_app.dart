import 'package:flutter/material.dart';
import 'package:sic/pages/home/home.dart';
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
        child: ListView.builder(itemCount : widget.items.length + 1,
            itemBuilder: (BuildContext context, int position) {
              return _getItem(position);
        }),
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

  _getItem(int position){

    if(position == 0){ //header
      return new DrawerHeader(child: new Center(child: new Image.network("http://i.imgur.com/ioMrqvL.png", height: 100.0)));
    }else{ //menu item
      final menuItem = widget.items[position - 1];
      return new ListTile(
          leading: new Center(child: menuItem.icon),
          title: new Text(menuItem.title),
          onTap: () => _select(position - 1), selected: position - 1 == selectedMenuPosition);
    }
  }
}