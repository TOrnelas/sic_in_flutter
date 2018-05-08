import 'package:flutter/material.dart';
import 'pages/home.dart';

class App extends StatefulWidget {

  App({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {

  var selectedSideMenuPos = 0;

  @override
  Widget build(BuildContext context) {

    var items = <Widget>[
      new DrawerHeader(child: new Center(child: new Image.network("http://i.imgur.com/ioMrqvL.png", height: 100.0))),
      new ListTile(title: new Text("Home"), onTap: () => _select(0)),
      new ListTile(title: new Text("EPG"), onTap: () => _select(1)),
    ];

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(child: _getPageForSelectedIndex()),
      drawer: new Drawer(
        child: ListView(
          children: items,
        ),
      ),
    );
  }

  _select(int index){

    selectedSideMenuPos = index;
    setState(() => {});
    if(Navigator.of(context).canPop())
      Navigator.of(context).pop();
  }

  _getPageForSelectedIndex(){

    switch (selectedSideMenuPos){
      case 0:
        return new Home();
      default:
        return new Text(selectedSideMenuPos.toString());
    }
  }
}