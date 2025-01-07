import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jr_tube/component/custom_youtube_player.dart';
import 'package:jr_tube/model/video_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomYoutubePlayer(
            videoModel: VideoModel(id: '234324', title: 'sdfdfdfsdf')));
  }
}
