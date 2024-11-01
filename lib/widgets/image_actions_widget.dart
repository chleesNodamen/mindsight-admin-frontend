import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/app_export.dart';

class ImageActionsWidget extends StatelessWidget {
  final String imageUrl;

  const ImageActionsWidget({super.key, required this.imageUrl});

  // 이미지 보기 함수
  void _openImageInNewTab() {
    if (imageUrl.isNotEmpty) {
      html.window.open(imageUrl, '_blank');
    } else {
      showSimpleMessage(Get.context!, "이미지 URL이 유효하지 않습니다");
    }
  }

  // 이미지 다운로드 함수
  Future<void> _downloadImage() async {
    if (imageUrl.isNotEmpty) {
      try {
        // 이미지 데이터를 가져옴
        final response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          html.AnchorElement(href: url)
            ..setAttribute("download", imageUrl.split('/').last)
            ..click();
          html.Url.revokeObjectUrl(url);
        } else {
          showSimpleMessage(Get.context!, '이미지를 다운로드할 수 없습니다');
        }
      } catch (e) {
        showSimpleMessage(Get.context!, '이미지를 다운로드하는 동안 오류가 발생했습니다');
      }
    } else {
      showSimpleMessage(Get.context!, '이미지 URL이 유효하지 않습니다');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Text(
            "이미지 보기",
            style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue),
          ),
          onTap: () => _openImageInNewTab(),
        ),
        const SizedBox(width: 4),
        CustomImageView(
          onTap: () => _downloadImage(),
          imagePath: IconConstant.download,
        )
      ],
    );
  }
}
