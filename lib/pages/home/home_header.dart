import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sic/main.dart';

class HomeHeader extends StatefulWidget {
  @override
  _HomeHeaderState createState() => new _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {

  VideoPlayerController _controller;
  bool isPlaying = false;
  bool areControllersVisible = true;

  @override
  void initState() {

    super.initState();

    //init video player controller
    _controller = new VideoPlayerController.network('http://live.impresa.pt/live/sic/sic.m3u8');
//    _controller = new VideoPlayerController.network("http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_20mb.mp4");
    _controller.initialize();
    _controller.play();

    _controller.addListener(() {
      isPlaying = _controller.value.isPlaying;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    return new GestureDetector(
      onTap: () {
        areControllersVisible = !areControllersVisible;
        setState(() {});
      },
      child: new Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
          new Container(
            child: new AspectRatio(
              aspectRatio: 1280 / 720,
              child:  new VideoPlayer(_controller)
            ),
            color: Colors.black,
          ),
          new Opacity(
            opacity: areControllersVisible ? 1.0 : 0.0,
            child: new Container(
              decoration: new BoxDecoration(boxShadow: [new BoxShadow(color: Colors.black38)], borderRadius: new BorderRadius.only(bottomLeft: new Radius.circular(5.0), topLeft: new Radius.circular(5.0))),
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                 new IconButton(icon: new Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white), onPressed: () => _playPause()),
                 new IconButton(icon: new Icon(Icons.fullscreen, color: Colors.white), onPressed: () => _goFullScreen())
                ]
              ),
            ),
          )
        ]
      ),
    );
  }

  @override
  void dispose() {

    super.dispose();
    _controller.dispose();
  }

  _goFullScreen() {

    _controller.pause();

    var encodedUrl = "http://live.impresa.pt/live/sic/sic.m3u8".replaceAll("/", "[]");
    Navigator.pushNamed(context, "/fullScreenPlayer/" + encodedUrl);
  }

  _playPause() {

    if(_controller.value.isPlaying){
      _controller.pause();
    }else{
      _controller.play();
    }
  }
}
