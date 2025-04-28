// ignore: deprecated_member_use
import 'dart:async';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/widgets/circular_custom_image_view.dart';
import 'package:mindsight_admin_page/widgets/image_content_dialog.dart';

class ImageActionsWidget extends StatelessWidget {
  final String imageUrl;
  final bool isCircular;

  const ImageActionsWidget({
    super.key,
    required this.imageUrl,
    this.isCircular = false,
  });

  // View image 함수
  void _openImageDialog(BuildContext context) {
    if (imageUrl.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: ImageDialogContent(
              url: imageUrl,
              isCircular: isCircular,
            ),
          );
        },
      );
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
    Widget imageWidget;
    if (isCircular) {
      imageWidget = CircularCustomImageView(
        imagePath: imageUrl,
        size: 110,
      );
    } else {
      imageWidget = CustomImageView(
        imagePath: imageUrl,
        width: 110,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            imageWidget,
            const SizedBox(width: 10),
            InkWell(
              onTap: () => _openImageDialog(context),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: appTheme.skyBlue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "View image".tr,
                  style: CustomTextStyles.bodyMediumSkyBlue,
                ),
              ),
            ),
            const SizedBox(width: 4),
            CustomImageView(
              onTap: () => _downloadImage(),
              imagePath: IconConstant.download,
            )
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
