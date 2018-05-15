import 'package:flutter/material.dart';
import '../../models/program.dart';
import '../../utils/app_utils.dart';
import '../../internet/repository.dart';

class HomeFooter extends StatefulWidget {
  @override
  _HomeFooterState createState() => new _HomeFooterState();
}

class _HomeFooterState extends State<HomeFooter> implements Callback{

  static const NUM_COLUMNS = 1.5;
  static const EPG_COLUMNS_HEIGHT = 200.0;

  var programs =  <Program>[];

  var screenWidth;
  var isPortrait;

  @override
  void initState() {

    super.initState();

    Repository.fetchEpgByChannelId("gen", this);
  }

  @override
  void onSuccess(List<Program> programmes) {
    print(programmes);
    this.programs = programmes;
    setState(() {}); //update UI
  }

  @override
  Widget build(BuildContext context) {

    isPortrait = AppUtils.isPortrait(context);
    screenWidth = AppUtils.getScreenWidth(context);

    return new Column(
      children: <Widget>[
        new Container(child: new Text("Playing now:"), padding: new EdgeInsets.only(left: 10.0, top: 5.0), width: screenWidth),
        new SizedBox(
          height: EPG_COLUMNS_HEIGHT,
          width: screenWidth,
          child: new ListView.builder(
            itemCount: programs.length,
            itemBuilder: (BuildContext context, int index){
              return _getItem(index);
            },
            scrollDirection: isPortrait ? Axis.horizontal : Axis.vertical
          )
        )
      ]
    );
  }

  _getItem(int position){

    if(isPortrait){
      return new Container(
        margin: new EdgeInsets.all(5.0),
        width: screenWidth / NUM_COLUMNS,
        child: new Card(
          child: new Column(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  new Center(child: new AspectRatio(aspectRatio: 1280 / 720, child: new Image.network(programs[position].imageUrl, fit: BoxFit.fill))),
                  new Opacity(opacity: programs[position].isPlayingNow() ? 1.0 :  0.0, child: new Container(child: new Text("NOW", style: new TextStyle(color: Colors.white)), color: Colors.redAccent, padding: new EdgeInsets.all(4.0)))
                ]
              ),
              new Center(child: new Text(programs[position].description, maxLines: 5))
            ]
          )
        )
      );
    }else{
      return new SizedBox(
          height: screenWidth / NUM_COLUMNS,
          child: new Text(programs[position].title));
    }
  }
}