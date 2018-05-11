import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeHeader extends StatefulWidget {
  @override
  _HomeHeaderState createState() => new _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {

  VideoPlayerController _controller;
  bool isPlaying = false;

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

    return new AspectRatio(
        aspectRatio: 1280 / 720,
        child:  new VideoPlayer(_controller)
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
