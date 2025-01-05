// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/app_export.dart';

class ImageActionsWidget extends StatelessWidget {
  final String imageUrl;

  const ImageActionsWidget({super.key, required this.imageUrl});

  // View image 함수
  void _openImageInNewTab() {
    if (imageUrl.isNotEmpty) {
      html.window.open(imageUrl, '_blank');
    } else {
      showSimpleMessage("Invalid image URL".tr);
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
          showSimpleMessage('Cannot download image'.tr);
        }
      } catch (e) {
        showSimpleMessage('Error downloading image'.tr);
      }
    } else {
      showSimpleMessage('Invalid image URL'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Text(
            "View image".tr,
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
