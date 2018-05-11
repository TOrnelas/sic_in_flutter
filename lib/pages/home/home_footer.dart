import 'package:flutter/material.dart';
import '../../models/program.dart';
import '../../utils/app_utils.dart';

class HomeFooter extends StatefulWidget {
  @override
  _HomeFooterState createState() => new _HomeFooterState();
}

class _HomeFooterState extends State<HomeFooter> {

  static const NUM_COLUMNS = 2.5;

  var programs = [
    new Program(1, 0, 0, "Program 1", "Lorem ipsum description", "http://images-cdn.impresa.pt/sic/2017-04-18-logo_teste3.png/16x9/mw-320"),
    new Program(1, 0, 0, "Program 2", "Lorem ipsum description", "http://images-cdn.impresa.pt/sic/2017-04-18-logo_teste3.png/16x9/mw-320"),
    new Program(1, 0, 0, "Program 3", "Lorem ipsum description", "http://images-cdn.impresa.pt/sic/2017-04-18-logo_teste3.png/16x9/mw-320"),
    new Program(1, 0, 0, "Program 4", "Lorem ipsum description", "http://images-cdn.impresa.pt/sic/2017-04-18-logo_teste3.png/16x9/mw-320"),
    new Program(1, 0, 0, "Program 5", "Lorem ipsum description", "http://images-cdn.impresa.pt/sic/2017-04-18-logo_teste3.png/16x9/mw-320"),
    new Program(1, 0, 0, "Program 6", "Lorem ipsum description", "http://images-cdn.impresa.pt/sic/2017-04-18-logo_teste3.png/16x9/mw-320"),
    new Program(1, 0, 0, "Program 7", "Lorem ipsum description", "http://images-cdn.impresa.pt/sic/2017-04-18-logo_teste3.png/16x9/mw-320"),
    new Program(1, 0, 0, "Program 8", "Lorem ipsum description", "http://images-cdn.impresa.pt/sic/2017-04-18-logo_teste3.png/16x9/mw-320"),
    new Program(1, 0, 0, "Program 9", "Lorem ipsum description", "http://images-cdn.impresa.pt/sic/2017-04-18-logo_teste3.png/16x9/mw-320"),
    new Program(1, 0, 0, "Program 10", "Lorem ipsum description", "http://images-cdn.impresa.pt/sic/2017-04-18-logo_teste3.png/16x9/mw-320"),
    new Program(1, 0, 0, "Program 11", "Lorem ipsum description", "http://images-cdn.impresa.pt/sic/2017-04-18-logo_teste3.png/16x9/mw-320")
  ];

  var screenWidth;
  var isPortrait;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

   isPortrait = AppUtils.isPortrait(context);
    screenWidth = AppUtils.getScreenWidth(context);

    return SizedBox(
        height: 120.0,
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
      return new SizedBox(width: screenWidth / NUM_COLUMNS, child: new Text(programs[position].title));
    }else{
      return new SizedBox(height: screenWidth / NUM_COLUMNS, child: new Text(programs[position].title));
    }
  }
}