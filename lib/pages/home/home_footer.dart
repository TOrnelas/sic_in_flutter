import 'package:flutter/material.dart';
import '../../models/program.dart';
import '../../utils/app_utils.dart';
import '../../internet/repository.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeFooter extends StatefulWidget {
  @override
  _HomeFooterState createState() => new _HomeFooterState();
}

class _HomeFooterState extends State<HomeFooter> implements Callback{

  var numColumns;
  var epgColumnsHeight;

  var programs =  <Program>[];

  var screenWidth;
  var isPortrait;

  var scrollController = new ScrollController();

  @override
  void initState() {

    super.initState();

    //call epg
    Repository.fetchEpgByChannelId("gen", this);
  }


  @override
  void dispose() {

    super.dispose();
  }

  @override
  void onSuccess(List<Program> programmes) {

    print(programmes);
    this.programs = programmes;
    _scrollToOnNowPosition();
  }

  @override
  void onError() {
    // TODO: implement onError
  }

  @override
  Widget build(BuildContext context) {

    isPortrait = AppUtils.isPortrait(context);
    screenWidth = AppUtils.getScreenWidth(context);
    numColumns = isPortrait ? 1.5 : 3.5;
    epgColumnsHeight = isPortrait ? 225.0 : 185.0;

    return new Column(

      children: <Widget>[
        new GestureDetector(
          child: new Container(
              child: new Text(AppUtils.getStringForLanguage(context, "schedule") + ":"),
              padding: new EdgeInsets.only(left: 10.0, top: 5.0),
              width: screenWidth
          ),
          onTap: () => _scrollToOnNowPosition()
        ),
        new SizedBox(
          height: epgColumnsHeight,
          width: screenWidth,
          child: new ListView.builder(
            controller: scrollController,
            itemCount: programs.length,
            itemBuilder: (BuildContext context, int index){
              return _getItem(index);
            },
            scrollDirection: Axis.horizontal
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
            width: screenWidth / numColumns,
            child: new Card(
                elevation: 2.0,
                child: new Column(
                    children: <Widget>[
                      new Stack(
                          children: <Widget>[
                            new Center(child: new AspectRatio(aspectRatio: 1280 / 720, child: new Image.network(programs[position].imageUrl, fit: BoxFit.fill))),
                            new Opacity(opacity: programs[position].isFromThePast() ? 0.0 : 1.0 , child: new Container(padding: new EdgeInsets.all(4.0),
                                child: new Text(programs[position].getStartsAtTime(context), style: new TextStyle(color: Colors.white)), color: new Color(0xFFFF9F9F)))
                          ],
                          alignment: AlignmentDirectional.topEnd
                      ),
                      new ListTile(
                          trailing: programs[position].isPlayingNow() ?
                          new Container(
                              child: new Text(AppUtils.getStringForLanguage(context, "now_label"),
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
    var celWidth = screenWidth / numColumns + 5.0;

    for(var i = 0; i < programs.length; i++){
      if(programs[i].isPlayingNow()){
        currentProgramIndex = i;
        break;
      }
    }

    return currentProgramIndex * celWidth;
  }

  _launchWebView(String externalUrl) {
    launch(externalUrl, forceWebView: true);
  }

  _scrollToOnNowPosition(){
    setState(() {
      scrollController.animateTo(_getScrollOffset(), duration: new Duration(milliseconds: 800), curve: new ElasticOutCurve());
    });
  }
}