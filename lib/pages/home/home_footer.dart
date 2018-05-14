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

    return SizedBox(
      height: 220.0,
      width: 120.0,
      child: new ListView.builder(
        itemCount: programs.length,
        itemBuilder: (BuildContext context, int index){
          return _getItem(index);
        },
        scrollDirection: isPortrait ? Axis.horizontal : Axis.vertical
      )
    );
  }

  _getItem(int position){

    if(isPortrait){
      return new SizedBox(
          width: screenWidth / NUM_COLUMNS,
          child: new Column(
              children: <Widget>[
                new Center(child: new Text(programs[position].getStartEndWithFormat())),
                new Center(child: new AspectRatio(aspectRatio: 1280 / 720, child: new Image.network(programs[position].imageUrl)))
            ]
          )
      );
    }else{
      return new SizedBox(
          height: screenWidth / NUM_COLUMNS,
          child: new Text(programs[position].title));
    }
  }
}