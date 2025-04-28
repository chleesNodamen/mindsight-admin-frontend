/*
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
*/

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/widgets/circular_custom_image_view.dart';
import 'dart:async';

class ImageDialogContent extends StatelessWidget {
  final String url;
  final bool isCircular;

  const ImageDialogContent({
    super.key,
    required this.url,
    this.isCircular = false,
  });

  Future<ImageInfo> _getImageInfo(String url) async {
    final completer = Completer<ImageInfo>();
    final image = NetworkImage(url);
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info);
      }),
    );
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ImageInfo>(
      future: _getImageInfo(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 300,
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return SizedBox(
            width: 300,
            height: 300,
            child: Center(child: Text("Failed to load image".tr)),
          );
        } else if (snapshot.hasData) {
          final imageInfo = snapshot.data!;
          final double originalWidth = imageInfo.image.width.toDouble();
          final double originalHeight = imageInfo.image.height.toDouble();

          const double maxWidth = 600;
          const double maxHeight = 600;

          double scale = 1.0;
          if (originalWidth > maxWidth || originalHeight > maxHeight) {
            scale = (maxWidth / originalWidth).clamp(0, 1);
            scale = scale > (maxHeight / originalHeight).clamp(0, 1)
                ? (maxHeight / originalHeight).clamp(0, 1)
                : scale;
          }

          final double targetWidth = originalWidth * scale;
          final double targetHeight = originalHeight * scale;

          Widget imageWidget;
          if (isCircular) {
            imageWidget = CircularCustomImageView(
              imagePath: url,
              size: targetWidth,
            );
          } else {
            imageWidget = Image.network(
              url,
              fit: BoxFit.contain, // ✅ 비율 유지
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: targetWidth,
                height: targetHeight,
                child: InteractiveViewer(
                  child: imageWidget,
                ),
              ),
              // const SizedBox(height: 10),
              SizedBox(
                height: 40,
                width: targetWidth,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close".tr),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
