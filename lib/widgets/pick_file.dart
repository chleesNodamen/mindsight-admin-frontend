// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/widgets/circular_custom_image_view.dart';

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
    required this.isCircular, // Added parameter
    this.errorText,
  });

  final String? initialUrl;
  final void Function(html.File? pickedFile) onFilePicked;
  final String labelText;
  final String? toolTip;
  final bool essential;
  final String hintText;
  final List<String> fileExtension;
  final bool isCircular; // Added field
  final String? errorText;

  @override
  State<PickFile> createState() => _PickFileState();
}

class _PickFileState extends State<PickFile> {
  String? pickedFileName;
  html.File? pickedFile;
  String? pickedFileUrl;

  // Simple extension to MIME type mapping
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

  @override
  void initState() {
    super.initState();
    pickedFileName = widget.initialUrl;
  }

  bool _isImageFile(String? fileName) {
    if (fileName == null) return false;
    final extension = fileName.split('.').last.toLowerCase();
    return _imageMimeTypes.containsKey(extension);
  }

  Future<void> onPickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: widget.fileExtension,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;

        // Determine MIME type based on file extension
        String? extension = file.extension?.toLowerCase();
        String? mimeType = extension != null
            ? (_imageMimeTypes[extension] ?? _additionalMimeTypes[extension])
            : null;

        if (mimeType == null) {
          // Handle unsupported file types if necessary
          Logger.error('Unsupported file type: .$extension');
          return;
        }

        if (_imageMimeTypes.containsKey(extension)) {
          // Handle image files
          final blob = html.Blob([file.bytes!], mimeType);
          final url = html.Url.createObjectUrlFromBlob(blob);

          pickedFile = html.File([blob], file.name, {'type': mimeType});
          pickedFileName = file.name;
          pickedFileUrl = url;
        } else {
          // Handle non-image files
          pickedFile = html.File([file.bytes!], file.name, {'type': mimeType});
          pickedFileName = file.name;
          pickedFileUrl = null;
        }

        setState(() {});
        widget.onFilePicked(pickedFile);
      } else {
        Logger.info('File selection canceled.');
      }
    } catch (e) {
      Logger.error('Error during file selection: $e');
    }
  }

  @override
  void dispose() {
    // Revoke the object URL to free up resources
    if (pickedFileUrl != null) {
      html.Url.revokeObjectUrl(pickedFileUrl!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPickedFileImage = _isImageFile(pickedFileName);
    final bool isInitialUrlImage = _isImageFile(widget.initialUrl);

    Widget displayImage;

    if (pickedFileUrl != null && isPickedFileImage) {
      if (widget.isCircular) {
        displayImage = CircularCustomImageView(
          imagePath: pickedFileUrl!,
          size: 100,
        );
      } else {
        displayImage = Image.network(
          pickedFileUrl!,
          width: 100,
          fit: BoxFit.cover,
        );
      }
    } else if (widget.initialUrl != null && isInitialUrlImage) {
      if (widget.isCircular) {
        displayImage = CircularCustomImageView(
          imagePath: widget.initialUrl!,
          size: 100,
        );
      } else {
        displayImage = Image.network(
          widget.initialUrl!,
          width: 100,
          fit: BoxFit.cover,
        );
      }
    } else {
      displayImage = const SizedBox.shrink();
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
                    style: CustomTextStyles.labelLargeBlack
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: widget.essential ? " *" : "",
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            widget.toolTip == null
                ? const SizedBox.shrink()
                : Tooltip(
                    message: widget.toolTip!,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    triggerMode: TooltipTriggerMode.tap,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Icon(
                      Icons.help_outline,
                      size: 20,
                    ),
                  ),
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

class PickFileFormField extends FormField<String?> {
  PickFileFormField({
    super.key,
    String? initialUrl,
    required void Function(html.File? pickedFile) onFilePicked,
    required String labelText,
    required bool essential,
    required String hintText,
    required List<String> fileExtension,
    String? toolTip,
    bool isCircular = false, // Added parameter
  }) : super(
          initialValue: initialUrl,
          validator: (file) {
            if (essential) {
              if (file == null) {
                return "     ${"This field is required.".tr}";
              }
            }
            return null;
          },
          builder: (FormFieldState<String?> state) {
            return PickFile(
              initialUrl: initialUrl,
              onFilePicked: (file) {
                onFilePicked(file);
                state.didChange(file?.name);
              },
              labelText: labelText,
              toolTip: toolTip,
              essential: essential,
              hintText: hintText,
              fileExtension: fileExtension,
              isCircular: isCircular, // Pass the parameter
              errorText: state.errorText,
            );
          },
        );
}
