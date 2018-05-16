import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {

  final videoUrl;

  FullScreenPlayer(this.videoUrl);

  @override
  _FullScreenPlayerState createState() => new _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {

  VideoPlayerController _controller;
  var isPlaying = true;
  var areControllersVisible = true;

  @override
  void initState() {

    super.initState();
    _controller = new VideoPlayerController.network(widget.videoUrl);
    _controller.initialize();
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    return new Container(
      child: new Stack(
        alignment: FractionalOffset.topLeft,
        children: <Widget>[
        new Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[
            new AspectRatio(
                aspectRatio: 1280 / 729,
                child: new GestureDetector(child: new VideoPlayer(_controller), onTap: () => toggleControllers())),
            new Opacity(
              opacity: areControllersVisible ? 1.0 : 0.0,
              child: new Container(
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Material(child: new IconButton(icon: new Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.redAccent), iconSize: 100.0, onPressed: () => togglePlayPause()), shadowColor: Colors.black38, color: Colors.transparent)
                    ],
                  )
              ),
            )
          ],
        ),
          new Opacity(opacity: areControllersVisible ? 1.0 : 0.0, child: new Container(padding: new EdgeInsets.all(10.0), child: new Material(child: new BackButton())))
      ]
    )
    );
  }

  togglePlayPause(){

    if(isPlaying){
      _controller.pause();
    }else{
      _controller.play();
    }
    isPlaying = !isPlaying;

    setState(() {});
  }

  toggleControllers(){
    areControllersVisible = !areControllersVisible;

    setState(() {});
  }

  @override
  void dispose() {

    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    _controller.dispose();
  }
}
