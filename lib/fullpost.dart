import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'post.dart';
import 'postdesign.dart';
import 'postvideodesign.dart';

// ignore: camel_case_types
class fullPost extends StatefulWidget {
  final Post post;
  fullPost(this.post);
  @override
  _fullPostState createState() => _fullPostState(post);
}

// ignore: camel_case_types
class _fullPostState extends State<fullPost> {
  final Post post;
  VideoPlayerController controller;
  _fullPostState(this.post);
  @override
  void initState() {
    super.initState();
    setState(() {
      if (post.type == "video")
        controller = VideoPlayerController.network(post.imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: post.type == 'image'
            ? postdesign(post, 'feed')
            : postvideodesign(post, 'feed'),
      ),
    );
  }
}
