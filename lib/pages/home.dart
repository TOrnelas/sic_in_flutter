import 'package:flutter/material.dart';
import '../utils/app_utils.dart';
import 'package:video_player/video_player.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  VideoPlayerController _controller;

  @override
  void initState() {
    debugPrint("a: ");
    super.initState();
    _controller = new VideoPlayerController.network('http://live.impresa.pt/live/sic/sic.m3u8');
//    _controller = new VideoPlayerController.network("http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_20mb.mp4");
    _controller.initialize();
    _controller.play();

    _controller.addListener(() {
      setState(() {});

      debugPrint("isPlaying? " + _controller.value.isPlaying.toString());
      debugPrint("position " + _controller.value.position.toString());
      debugPrint("duration " + _controller.value.duration.toString());
    });
  }

  @override
  Widget build(BuildContext context) {

    return new ListView(children: <Widget>[

      new AspectRatio(aspectRatio: 1280 / 720,
          child: new VideoPlayer(_controller)),
      new Row(children: <Widget>[
        new IconButton(icon: new Icon(Icons.play_arrow), onPressed: () => _controller.play()),
        new IconButton(icon: new Icon(Icons.pause), onPressed: () => _controller.pause()),
      ])
    ]);
  }
}
