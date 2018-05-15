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

  var NUM_COLUMNS = 1.5;
  var EPG_COLUMNS_HEIGHT = 225.0;

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
    _scrollToOnNowPostion();
  }

  @override
  Widget build(BuildContext context) {

    isPortrait = AppUtils.isPortrait(context);
    screenWidth = AppUtils.getScreenWidth(context);

    if(!isPortrait){
      NUM_COLUMNS = 3.5;
      EPG_COLUMNS_HEIGHT = 185.0;
    }else{
      NUM_COLUMNS = 1.5;
      EPG_COLUMNS_HEIGHT = 225.0;
    }

    return new Column(

      children: <Widget>[
        new GestureDetector(child: new Container(child: new Text("Schedule:"), padding: new EdgeInsets.only(left: 10.0, top: 5.0), width: screenWidth), onTap: () => _scrollToOnNowPostion()),
        new SizedBox(
          height: EPG_COLUMNS_HEIGHT,
          width: screenWidth,
          child: new ListView.builder(
            controller: scrollController,
            itemCount: programs.length,
            itemBuilder: (BuildContext context, int index){
              return _getItem(index);
            },
            scrollDirection: /*isPortrait ? */Axis.horizontal /*: *//*Axis.vertical*/
          )
        )
      ]
    );
  }

  _getItem(int position){

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
                            new Opacity(opacity: programs[position].isFromThePast() ? 0.0 : 1.0 , child: new Container(padding: new EdgeInsets.all(4.0),
                                child: new Text(programs[position].getStartsAtTime(), style: new TextStyle(color: Colors.white)), color: new Color(0xFFFF9F9F)))
                          ],
                          alignment: AlignmentDirectional.topEnd
                      ),
                      new ListTile(
                          trailing: programs[position].isPlayingNow() ?
                          new Container(
                              child: new Text("NOW",
                                  style: new TextStyle(
                                      color: Colors.white
                                  )
                              ),
                              color: Colors.redAccent,
                              padding: new EdgeInsets.all(4.0)) :
                          null,
                          title: new Text(programs[position].description, maxLines: 4)
                      )
                    ]
                )
            )
        )
    );
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

  _scrollToOnNowPostion(){
    setState(() {
      scrollController.animateTo(_getScrollOffset(), duration: new Duration(seconds: 1), curve: new ElasticOutCurve());
    }); //update UI
  }
}