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

    print(widget.videoUrl);
    return new Container(
      color: Colors.black38,
      child: new Stack(
        alignment: FractionalOffset.center,
        children: <Widget>[
          new Container(
            child: new Row(
              children: <Widget>[
                new Material(child: new IconButton(icon: new Icon(Icons.play_arrow), onPressed: null))
              ],
            )
          ),
          new AspectRatio(
              aspectRatio: 1280 / 729,
              child: new VideoPlayer(_controller))
        ],
      ),
    );
  }

  @override
  void dispose() {

    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _controller.dispose();
  }
}
