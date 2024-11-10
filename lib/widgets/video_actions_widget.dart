import 'package:mindsight_admin_page/app_export.dart';
import 'video_player_widget.dart'; // VideoPlayerWidget 경로에 맞게 수정

class VideoActionsWidget extends StatelessWidget {
  final String videoUrl;

  const VideoActionsWidget({super.key, required this.videoUrl});

  // 비디오 보기 함수
  void _openVideoPlayer(BuildContext context) {
    if (videoUrl.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 비디오 플레이어
                  VideoPlayerWidget(videoUrl: videoUrl),
                  // 닫기 버튼
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('닫기'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      showSimpleMessage(Get.context!, "비디오 URL이 유효하지 않습니다");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Text(
            "미디어 재생",
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
