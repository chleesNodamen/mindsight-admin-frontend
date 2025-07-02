// ignore: deprecated_member_use
import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:el_tooltip/el_tooltip.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/widgets/circular_custom_image_view.dart';
import 'package:image/image.dart' as img;
import 'package:mindsight_admin_page/widgets/image_actions_widget.dart';
import 'package:mindsight_admin_page/widgets/image_content_dialog.dart';

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
  //         Uint8List? resizedBytes = await resizeImage(file.bytes!);
  //         if (resizedBytes == null) {
  //           Logger.error('이미지 리사이즈 실패');
  //           return;
  //         }
  //         _imageBytes = resizedBytes;
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
      final uploadInput = html.FileUploadInputElement();
      uploadInput.accept = widget.fileExtension.map((e) => '.$e').join(',');
      uploadInput.click();

      uploadInput.onChange.listen((e) async {
        final file = uploadInput.files?.first;
        if (file == null) return;

        final extension = file.name.split('.').last.toLowerCase();
        final mimeType =
            _imageMimeTypes[extension] ?? _additionalMimeTypes[extension];

        if (mimeType == null) {
          Logger.error('Unsupported file type: .$extension');
          return;
        }

        pickedFileName = file.name;

        if (_imageMimeTypes.containsKey(extension)) {
          final reader = html.FileReader();
          reader.readAsArrayBuffer(file);
          reader.onLoadEnd.listen((event) async {
            if (reader.result is! Uint8List && reader.result is! ByteBuffer) {
              Logger.error('Invalid image file buffer');
              return;
            }

            final buffer = reader.result is Uint8List
                ? reader.result as Uint8List
                : Uint8List.view(reader.result as ByteBuffer);

            Uint8List? resizedBytes = await resizeImage(buffer);
            if (resizedBytes == null) {
              Logger.error('이미지 리사이즈 실패');
              return;
            }

            _imageBytes = resizedBytes;
            _showCropDialog();
          });
        } else {
          pickedFile = file;
          pickedFileUrl = null;
          widget.onFilePicked(file);
          setState(() {});
        }
      });
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
              child: Text("Comfirm".tr,
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(width: 10),

          // CustomElevatedButton(
          //   text: "Cancel".tr,
          //   buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
          //   buttonStyle: CustomButtonStyles.fillRedTransparent,
          //   margin: const EdgeInsets.only(left: 16),
          //   height: 44,
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          // CustomElevatedButton(
          //   text: "Comfirm".tr,
          //   buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
          //   buttonStyle: CustomButtonStyles.fillPrimary,
          //   height: 44,
          //   onPressed: () => _cropController.crop(),
          // ),
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

  // void _openImageDialog(BuildContext context) {
  //   if (imageUrl.isNotEmpty) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           contentPadding: EdgeInsets.zero,
  //           content: ImageDialogContent(
  //             url: imageUrl,
  //             isCircular: isCircular,
  //           ),
  //         );
  //       },
  //     );
  //   } else {
  //     showSimpleMessage("Invalid image URL".tr);
  //   }
  // }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: ImageDialogContent(
            url: imageUrl,
            isCircular: false,
          ),
        );
      },
    );

    // showDialog(
    //   context: context,
    //   builder: (context) => Dialog(
    //     insetPadding: EdgeInsets.zero,
    //     child: Container(
    //       // padding: const EdgeInsets.all(10),
    //       color: Colors.amber,
    //       // height: 600,
    //       // width: 900,
    //       child: Column(
    //         children: [
    //           Expanded(
    //             child: InteractiveViewer(
    //               child: FutureBuilder<ImageInfo>(
    //                 future: _getImageInfo(url),
    //                 builder: (context, snapshot) {
    //                   if (snapshot.hasData) {
    //                     final imageInfo = snapshot.data!;
    //                     return Image.network(
    //                       url,
    //                       width: imageInfo.image.width * 2,
    //                       height: imageInfo.image.height * 2,
    //                       fit: BoxFit.contain, // 가득 채움
    //                     );
    //                   } else {
    //                     return const Center(child: CircularProgressIndicator());
    //                   }
    //                 },
    //               ),
    //             ),
    //           ),
    //           const SizedBox(height: 10),
    //           TextButton(
    //               onPressed: () => Navigator.of(context).pop(),
    //               child: const Text('확인')),
    //           const SizedBox(height: 10),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

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
