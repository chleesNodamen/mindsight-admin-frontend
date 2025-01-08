// // ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html;
// import 'package:http/http.dart' as http;
// import 'package:mindsight_admin_page/app_export.dart';
// import 'package:mindsight_admin_page/widgets/circular_custom_image_view.dart';

// class ImageDialogContent extends StatelessWidget {
//   final String url;

//   const ImageDialogContent({super.key, required this.url});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         InteractiveViewer(
//           child: Image.network(
//             url,
//             fit: BoxFit.contain,
//             loadingBuilder: (context, child, loadingProgress) {
//               if (loadingProgress == null) return child;
//               return const SizedBox(
//                 width: 300,
//                 height: 300,
//                 child: Center(child: CircularProgressIndicator()),
//               );
//             },
//             errorBuilder: (context, error, stackTrace) {
//               return SizedBox(
//                 width: 300,
//                 height: 300,
//                 child: Center(child: Text("Failed to load image".tr)),
//               );
//             },
//           ),
//         ),
//         Align(
//           alignment: Alignment.centerRight,
//           child: TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Close'.tr),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ImageActionsWidget extends StatelessWidget {
//   final String imageUrl;
//   final bool isCircular;

//   const ImageActionsWidget({
//     super.key,
//     required this.imageUrl,
//     this.isCircular = false,
//   });

//   // View image 함수
//   void _openImageDialog(BuildContext context) {
//     if (imageUrl.isNotEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             contentPadding: EdgeInsets.zero,
//             content: ImageDialogContent(url: imageUrl),
//           );
//         },
//       );
//     } else {
//       showSimpleMessage("Invalid image URL".tr);
//     }
//   }

//   // 이미지 다운로드 함수
//   Future<void> _downloadImage() async {
//     if (imageUrl.isNotEmpty) {
//       try {
//         // 이미지 데이터를 가져옴
//         final response = await http.get(Uri.parse(imageUrl));
//         if (response.statusCode == 200) {
//           final bytes = response.bodyBytes;
//           final blob = html.Blob([bytes]);
//           final url = html.Url.createObjectUrlFromBlob(blob);
//           html.AnchorElement(href: url)
//             ..setAttribute("download", imageUrl.split('/').last)
//             ..click();
//           html.Url.revokeObjectUrl(url);
//         } else {
//           showSimpleMessage('Cannot download image'.tr);
//         }
//       } catch (e) {
//         showSimpleMessage('Error downloading image'.tr);
//       }
//     } else {
//       showSimpleMessage('Invalid image URL'.tr);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget imageWidget;
//     if (isCircular) {
//       imageWidget = CircularCustomImageView(
//         imagePath: imageUrl,
//         size: 110,
//       );
//     } else {
//       imageWidget = CustomImageView(
//         imagePath: imageUrl,
//         width: 110,
//       );
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             InkWell(
//               child: Text(
//                 "View image".tr,
//                 style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
//                   decoration: TextDecoration.underline,
//                   decorationColor: appTheme.skyBlue,
//                 ),
//               ),
//               onTap: () => _openImageDialog(context),
//             ),
//             const SizedBox(width: 4),
//             CustomImageView(
//               onTap: () => _downloadImage(),
//               imagePath: IconConstant.download,
//             )
//           ],
//         ),
//         const SizedBox(height: 8),
//         imageWidget,
//       ],
//     );
//   }
// }

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/widgets/circular_custom_image_view.dart';

class ImageDialogContent extends StatelessWidget {
  final String url;
  final bool isCircular;

  const ImageDialogContent({
    super.key,
    required this.url,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (isCircular) {
      imageWidget = CircularCustomImageView(
        imagePath: url,
        size: 300,
      );
    } else {
      imageWidget = Image.network(
        url,
        fit: BoxFit.contain,
        width: 300,
        height: 300,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const SizedBox(
            width: 300,
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            width: 300,
            height: 300,
            child: Center(child: Text("Failed to load image".tr)),
          );
        },
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InteractiveViewer(
          child: imageWidget,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'.tr),
          ),
        ),
      ],
    );
  }
}

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
            InkWell(
              child: Text(
                "View image".tr,
                style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: appTheme.skyBlue,
                ),
              ),
              onTap: () => _openImageDialog(context),
            ),
            const SizedBox(width: 4),
            CustomImageView(
              onTap: () => _downloadImage(),
              imagePath: IconConstant.download,
            )
          ],
        ),
        const SizedBox(height: 8),
        imageWidget,
      ],
    );
  }
}
