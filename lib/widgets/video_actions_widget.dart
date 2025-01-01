// import 'package:mindsight_admin_page/app_export.dart';
// import 'package:video_player/video_player.dart';

// class VideoDialogContent extends StatefulWidget {
//   final String m3u8Url;

//   const VideoDialogContent({super.key, required this.m3u8Url});

//   @override
//   State<VideoDialogContent> createState() => _VideoDialogContentState();
// }

// class _VideoDialogContentState extends State<VideoDialogContent> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();

//     Logger.info("플레이: ${widget.m3u8Url}");

//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.m3u8Url))
//       ..initialize().then((_) {
//         setState(() {
//           _isInitialized = true;
//           _controller.play();
//         });
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.maxFinite,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _isInitialized
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
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
//               child: const Text('닫기'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class VideoActionsWidget extends StatelessWidget {
//   final String videoUrl;

//   const VideoActionsWidget({super.key, required this.videoUrl});

//   // 비디오 보기 함수
//   void _openVideoPlayer(BuildContext context) {
//     if (videoUrl.isNotEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             contentPadding: EdgeInsets.zero,
//             content: VideoDialogContent(m3u8Url: videoUrl),
//           );
//         },
//       );
//     } else {
//       showSimpleMessage("비디오 URL이 유효하지 않습니다");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         InkWell(
//           child: Text(
//             "미디어 재생",
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

import 'package:mindsight_admin_page/app_export.dart';
import 'package:video_player/video_player.dart';

class VideoDialogContent extends StatefulWidget {
  final String m3u8Url;

  const VideoDialogContent({super.key, required this.m3u8Url});

  @override
  State<VideoDialogContent> createState() => _VideoDialogContentState();
}

class _VideoDialogContentState extends State<VideoDialogContent> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    Logger.info("플레이: ${widget.m3u8Url}");

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.m3u8Url))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _controller.play();
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
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
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
              child: Text('닫기'.tr),
            ),
          ),
        ],
      ),
    );
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
            content: VideoDialogContent(m3u8Url: videoUrl),
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
            "미디어 재생".tr,
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
