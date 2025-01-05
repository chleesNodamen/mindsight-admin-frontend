// import 'package:video_player/video_player.dart';
// import 'package:mindsight_admin_page/app_export.dart';

// class VideoDialogContent extends StatefulWidget {
//   final String url;

//   const VideoDialogContent({super.key, required this.url});

//   @override
//   State<VideoDialogContent> createState() => _VideoDialogContentState();
// }

// class _VideoDialogContentState extends State<VideoDialogContent> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;
//   bool _isAudioOnly = false;

//   @override
//   void initState() {
//     super.initState();

//     Logger.info("플레이: ${widget.url}");

//     // 파일 확장자를 기반으로 오디오 파일인지 확인
//     if (widget.url.toLowerCase().endsWith('.wav') ||
//         widget.url.toLowerCase().endsWith('.mp3')) {
//       _isAudioOnly = true;
//     }

//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
//       ..initialize().then((_) {
//         setState(() {
//           _isInitialized = true;
//           _controller.setLooping(false);
//           _controller.play();
//         });
//       }).catchError((error) {
//         Logger.error("미디어 재생 실패: $error");
//         showSimpleMessage("미디어를 재생할 수 없습니다.".tr);
//         Navigator.of(context).pop();
//       });

//     // 리스너 추가: 컨트롤러 상태가 변경될 때마다 UI 갱신
//     _controller.addListener(_videoListener);
//   }

//   void _videoListener() {
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   @override
//   void dispose() {
//     // 리스너 제거
//     _controller.removeListener(_videoListener);
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 다이얼로그 너비 설정
//     final double dialogWidth = MediaQuery.of(context).size.width * 0.5;

//     return SizedBox(
//       width: dialogWidth,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _isInitialized
//               ? _isAudioOnly
//                   ? _buildAudioUI()
//                   : AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(_controller),
//                     )
//               : const SizedBox(
//                   height: 200,
//                   child: Center(child: CircularProgressIndicator()),
//                 ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: TextButton(
//               onPressed: () {
//                 _controller.pause();
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'.tr),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAudioUI() {
//     return Container(
//       width: double.infinity,
//       height: 200, // 고정 높이 설정
//       color: Colors.black, // 배경색 설정 (필요에 따라 변경 가능)
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(
//             Icons.music_note,
//             size: 100,
//             color: Colors.white,
//           ),
//           const SizedBox(height: 20),
//           VideoProgressIndicator(
//             _controller,
//             allowScrubbing: true,
//             colors: const VideoProgressColors(
//               playedColor: Colors.blue,
//               bufferedColor: Colors.grey,
//               backgroundColor: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(
//                   _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _controller.value.isPlaying
//                         ? _controller.pause()
//                         : _controller.play();
//                   });
//                 },
//               ),
//               Text(
//                 '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
//   }
// }

// class VideoActionsWidget extends StatelessWidget {
//   final String videoUrl;

//   const VideoActionsWidget({super.key, required this.videoUrl});

//   void _openVideoPlayer(BuildContext context) {
//     if (videoUrl.isNotEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             contentPadding: EdgeInsets.zero,
//             content: VideoDialogContent(url: videoUrl),
//           );
//         },
//       );
//     } else {
//       showSimpleMessage("비디오 URL이 유효하지 않습니다".tr);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         InkWell(
//           child: Text(
//             "Media playback".tr,
//             style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
//               decoration: TextDecoration.underline,
//               decorationColor: appTheme.skyBlue,
//             ),
//           ),
//           onTap: () => _openVideoPlayer(context),
//         ),
//         // 다운로드 기능이 필요하다면 주석 해제
//         /*
//         const SizedBox(width: 4),
//         CustomImageView(
//           onTap: () => _downloadVideo(),
//           imagePath: IconConstant.download,
//         )
//         */
//       ],
//     );
//   }
// }

import 'package:video_player/video_player.dart';
import 'package:mindsight_admin_page/app_export.dart';

class VideoDialogContent extends StatefulWidget {
  final String url;

  const VideoDialogContent({super.key, required this.url});

  @override
  State<VideoDialogContent> createState() => _VideoDialogContentState();
}

class _VideoDialogContentState extends State<VideoDialogContent> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isAudioOnly = false;

  @override
  void initState() {
    super.initState();

    Logger.info("플레이: ${widget.url}");

    // 파일 확장자를 기반으로 오디오 파일인지 확인
    if (widget.url.toLowerCase().endsWith('.wav') ||
        widget.url.toLowerCase().endsWith('.mp3')) {
      _isAudioOnly = true;
    }

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _controller.setLooping(false);
          _controller.play();
        });
      }).catchError((error) {
        Logger.error("미디어 재생 실패: $error");
        showSimpleMessage("미디어를 재생할 수 없습니다.".tr);
        Navigator.of(context).pop();
      });

    // 리스너 추가: 컨트롤러 상태가 변경될 때마다 UI 갱신
    _controller.addListener(_videoListener);
  }

  void _videoListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // 리스너 제거
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 다이얼로그 너비 설정
    final double dialogWidth = MediaQuery.of(context).size.width * 0.6;

    return SizedBox(
      width: dialogWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _isInitialized
              ? _isAudioOnly
                  ? _buildAudioUI()
                  : _buildVideoUI()
              : const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                _controller.pause();
                Navigator.of(context).pop();
              },
              child: Text('Close'.tr),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioUI() {
    return Container(
      width: double.infinity,
      height: 200, // 고정 높이 설정
      color: Colors.black, // 배경색 설정 (필요에 따라 변경 가능)
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.music_note,
            size: 100,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Colors.blue,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ),
              Text(
                '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVideoUI() {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        VideoProgressIndicator(
          _controller,
          allowScrubbing: true,
          colors: const VideoProgressColors(
            playedColor: Colors.blue,
            bufferedColor: Colors.grey,
            backgroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
            ),
            Text(
              '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

class VideoActionsWidget extends StatelessWidget {
  final String videoUrl;

  const VideoActionsWidget({super.key, required this.videoUrl});

  void _openVideoPlayer(BuildContext context) {
    if (videoUrl.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: VideoDialogContent(url: videoUrl),
          );
        },
      );
    } else {
      showSimpleMessage("비디오 URL이 유효하지 않습니다".tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Text(
            "Media playback".tr,
            style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: appTheme.skyBlue,
            ),
          ),
          onTap: () => _openVideoPlayer(context),
        ),
        // 다운로드 기능이 필요하다면 주석 해제
        /*
        const SizedBox(width: 4),
        CustomImageView(
          onTap: () => _downloadVideo(),
          imagePath: IconConstant.download,
        )
        */
      ],
    );
  }
}
