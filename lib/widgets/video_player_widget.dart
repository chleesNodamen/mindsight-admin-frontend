// src/widgets/video_player_widget.dart

import 'package:flutter/material.dart';
import 'package:mindsight_admin_page/utils/logger.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    Logger.log("로드 비디오: ${widget.videoUrl}");

    _controller.initialize().then((_) {
      setState(() {
        _isInitialized = true;
      });
      _controller.play();
    }).catchError((error) {
      Logger.info(error.toString());
      setState(() {
        _isError = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return const Center(child: Text('비디오를 로드하는 데 실패했습니다.'));
    }

    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }
}
