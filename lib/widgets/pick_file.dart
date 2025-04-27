// ignore: deprecated_member_use
import 'dart:html' as html;
import 'package:crop_your_image/crop_your_image.dart';
import 'package:el_tooltip/el_tooltip.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/widgets/circular_custom_image_view.dart';
import 'package:image/image.dart' as img;

class PickFile extends StatefulWidget {
  const PickFile({
    super.key,
    this.initialUrl,
    this.toolTip,
    required this.essential,
    required this.onFilePicked,
    required this.labelText,
    required this.hintText,
    required this.fileExtension,
    required this.isCircular,
    this.errorText,
    this.aspectRatio = 16 / 9,
  });

  final String? initialUrl;
  final void Function(html.File? pickedFile) onFilePicked;
  final String labelText;
  final String? toolTip;
  final bool essential;
  final String hintText;
  final List<String> fileExtension;
  final bool isCircular;
  final String? errorText;
  final double? aspectRatio;

  @override
  State<PickFile> createState() => _PickFileState();
}

class _PickFileState extends State<PickFile> {
  String? pickedFileName;
  html.File? pickedFile;
  String? pickedFileUrl;
  Uint8List? _imageBytes;
  final CropController _cropController = CropController();

  final Map<String, String> _imageMimeTypes = {
    'png': 'image/png',
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'gif': 'image/gif',
  };

  final Map<String, String> _additionalMimeTypes = {
    'mp4': 'video/mp4',
    'mp3': 'audio/mpeg',
    'wav': 'audio/wav',
  };

  bool _isImageFile(String? fileName) {
    if (fileName == null) return false;
    final extension = fileName.split('.').last.toLowerCase();
    return _imageMimeTypes.containsKey(extension);
  }

  // Future<void> onPickFile() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: widget.fileExtension,
  //       withData: true,
  //     );

  //     if (result != null && result.files.isNotEmpty) {
  //       PlatformFile file = result.files.first;
  //       final extension = file.extension?.toLowerCase();
  //       final mimeType = extension != null
  //           ? (_imageMimeTypes[extension] ?? _additionalMimeTypes[extension])
  //           : null;

  //       if (mimeType == null) {
  //         Logger.error('Unsupported file type: .$extension');
  //         return;
  //       }

  //       if (_imageMimeTypes.containsKey(extension)) {
  //         _imageBytes = file.bytes;
  //         pickedFileName = file.name;
  //         _showCropDialog();
  //       } else {
  //         pickedFile = html.File([file.bytes!], file.name, {'type': mimeType});
  //         pickedFileName = file.name;
  //         pickedFileUrl = null;
  //         widget.onFilePicked(pickedFile);
  //         setState(() {});
  //       }
  //     }
  //   } catch (e) {
  //     Logger.error('Error during file selection: $e');
  //   }
  // }

  Future<void> onPickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: widget.fileExtension,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        final extension = file.extension?.toLowerCase();
        final mimeType = extension != null
            ? (_imageMimeTypes[extension] ?? _additionalMimeTypes[extension])
            : null;

        if (mimeType == null) {
          Logger.error('Unsupported file type: .$extension');
          return;
        }

        if (_imageMimeTypes.containsKey(extension)) {
          Uint8List? resizedBytes = await resizeImage(file.bytes!);
          if (resizedBytes == null) {
            Logger.error('이미지 리사이즈 실패');
            return;
          }
          _imageBytes = resizedBytes;
          pickedFileName = file.name;
          _showCropDialog();
        } else {
          pickedFile = html.File([file.bytes!], file.name, {'type': mimeType});
          pickedFileName = file.name;
          pickedFileUrl = null;
          widget.onFilePicked(pickedFile);
          setState(() {});
        }
      }
    } catch (e) {
      Logger.error('Error during file selection: $e');
    }
  }

  void _showCropDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title:
            Text("Crop and Rotate".tr, style: CustomTextStyles.labelLargeBlack),
        content: SizedBox(
          width: 400,
          height: 400,
          child: Crop(
            image: _imageBytes!,
            controller: _cropController,
            aspectRatio: widget.aspectRatio,
            baseColor: Colors.black,
            maskColor: Colors.black.withOpacity(0.6),
            onCropped: (CropResult result) {
              switch (result) {
                case CropSuccess(:final croppedImage):
                  final blob = html.Blob([croppedImage], 'image/png');
                  final url = html.Url.createObjectUrlFromBlob(blob);
                  pickedFile =
                      html.File([blob], pickedFileName!, {'type': 'image/png'});
                  pickedFileUrl = url;
                  widget.onFilePicked(pickedFile);
                  setState(() {});
                  Navigator.of(context).pop();
                  break;
                case CropFailure(:final cause):
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error'),
                      content: Text('Failed to crop image: $cause'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK')),
                      ],
                    ),
                  );
                  break;
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child:
                  Text("Cancel".tr, style: const TextStyle(color: Colors.red)),
            ),
          ),
          ElevatedButton(
            onPressed: () => _cropController.crop(),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text("Comfirm".tr),
            ),
          )
        ],
      ),
    );
  }

  Future<Uint8List?> resizeImage(Uint8List bytes, {int maxWidth = 800}) async {
    final originalImage = img.decodeImage(bytes);
    if (originalImage == null) return null;

    if (originalImage.width <= maxWidth) {
      return bytes;
    }

    final resizedImage = img.copyResize(originalImage, width: maxWidth);
    return Uint8List.fromList(img.encodeJpg(resizedImage));
  }

  void _showImageDialog(String url) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: InteractiveViewer(
          child: Image.network(url),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (pickedFileUrl != null) {
      html.Url.revokeObjectUrl(pickedFileUrl!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPickedFileImage = _isImageFile(pickedFileName);
    final bool isInitialUrlImage = _isImageFile(widget.initialUrl);

    Widget displayImage = const SizedBox.shrink();

    if (pickedFileUrl != null && isPickedFileImage) {
      displayImage = InkWell(
        onTap: () => _showImageDialog(pickedFileUrl!),
        child: widget.isCircular
            ? CircularCustomImageView(
                imagePath: pickedFileUrl!,
                size: 100,
              )
            : widget.aspectRatio != null && widget.aspectRatio! > 0
                ? AspectRatio(
                    aspectRatio: widget.aspectRatio!,
                    child: Image.network(
                      pickedFileUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.network(
                    pickedFileUrl!,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
      );
    } else if (widget.initialUrl != null && isInitialUrlImage) {
      displayImage = InkWell(
        onTap: () => _showImageDialog(widget.initialUrl!),
        child: widget.isCircular
            ? CircularCustomImageView(
                imagePath: widget.initialUrl!,
                size: 100,
              )
            : widget.aspectRatio != null && widget.aspectRatio! > 0
                ? AspectRatio(
                    aspectRatio: widget.aspectRatio!,
                    child: Image.network(
                      widget.initialUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.network(
                    widget.initialUrl!,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.labelText,
                    style: CustomTextStyles.labelLargeBlack.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: widget.essential ? " *" : "",
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            if (widget.toolTip != null)
              ElTooltip(
                showModal: false,
                showArrow: false,
                distance: 0,
                padding: EdgeInsets.zero,
                content: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black, // ✅ 더 진한 말풍선 배경
                      borderRadius: BorderRadius.circular(6), // ✅ 모서리 둥글게
                    ),
                    child: Text("${widget.toolTip}",
                        style: CustomTextStyles.labelLargeWhite)),
                position: ElTooltipPosition.topStart,
                child: const Icon(Icons.info_outline),
              ),
            // Tooltip(
            //   message: widget.toolTip!,
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //   triggerMode: TooltipTriggerMode.tap,
            //   decoration: BoxDecoration(
            //     color: Colors.grey.shade800,
            //     borderRadius: const BorderRadius.all(Radius.circular(10)),
            //   ),
            //   child: const Icon(
            //     Icons.info_outline,
            //     size: 20,
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: 353,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  widget.errorText != null ? Colors.red : Colors.grey.shade300,
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 280,
                    child: Text(
                      pickedFileName ?? widget.hintText,
                      style: TextStyle(color: Colors.grey.shade600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CustomImageView(
                    imagePath: IconConstant.upload,
                    onTap: onPickFile,
                  )
                ],
              ),
              if ((pickedFileUrl != null && isPickedFileImage) ||
                  (widget.initialUrl != null && isInitialUrlImage))
                const SizedBox(height: 8),
              displayImage,
            ],
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
