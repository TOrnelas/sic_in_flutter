import 'package:flutter/material.dart';
import '../../models/program.dart';
import '../../utils/app_utils.dart';
import '../../internet/repository.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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

  var scrollController = new ScrollController();

  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {

    super.initState();

    //webview
    flutterWebviewPlugin.close();

    //call epg
    Repository.fetchEpgByChannelId("gen", this);
  }


  @override
  void dispose() {

    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  @override
  void onSuccess(List<Program> programmes) {
    print(programmes);
    this.programs = programmes;
    setState(() {
      scrollController.animateTo(_getScrollOffset(), duration: new Duration(seconds: 1), curve: new ElasticOutCurve());
    }); //update UI
  }

  @override
  Widget build(BuildContext context) {

    isPortrait = AppUtils.isPortrait(context);
    screenWidth = AppUtils.getScreenWidth(context);

    return new Column(
      children: <Widget>[
        new Container(child: new Text("Schedule:"), padding: new EdgeInsets.only(left: 10.0, top: 5.0), width: screenWidth),
        new SizedBox(
          height: EPG_COLUMNS_HEIGHT,
          width: screenWidth,
          child: new ListView.builder(
            controller: scrollController,
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
      return new GestureDetector(
        onTap: () => _launchWebView(programs[position].externalUrl),
        child: new Container(
          margin: new EdgeInsets.all(5.0),
          width: screenWidth / NUM_COLUMNS,
          child: new Card(
            elevation: 2.0,
            child: new Column(
              children: <Widget>[
                new Stack(
                  children: <Widget>[
                    new Center(child: new AspectRatio(aspectRatio: 1280 / 720, child: new Image.network(programs[position].imageUrl, fit: BoxFit.fill))),
                    new Opacity(opacity: programs[position].isPlayingNow() ? 1.0 :  0.0, child: new Container(child: new Text("NOW", style: new TextStyle(color: Colors.white)), color: Colors.redAccent, padding: new EdgeInsets.all(4.0)))
                  ],
                  alignment: AlignmentDirectional.topEnd
                ),
                new Center(child: new Text(programs[position].description, maxLines: 5))
              ]
            )
          )
        )
      );
    }else{
      return new SizedBox(
        height: screenWidth / NUM_COLUMNS,
        child: new Text(programs[position].title));
    }
  }

  double _getScrollOffset() {

    num currentProgramIndex = 0;
    var celWidth = screenWidth / NUM_COLUMNS + 5.0;

    for(var i = 0; i < programs.length; i++){
      if(programs[i].isPlayingNow()){
        currentProgramIndex = i;
        break;
      }
    }

    return currentProgramIndex * celWidth;
  }

  _launchWebView(String externalUrl) {

    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("Comming soon")));
//    flutterWebviewPlugin.launch(externalUrl);
  }
}