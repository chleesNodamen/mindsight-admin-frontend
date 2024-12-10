import 'package:mindsight_admin_page/app_export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:universal_html/html.dart';

class PickFile extends StatefulWidget {
  const PickFile({
    super.key,
    this.initialUrl,
    required this.onFilePicked,
    required this.labelText,
    required this.hintText,
    required this.fileExtension,
  });

  final String? initialUrl;
  final void Function(File? pickedFile) onFilePicked;
  final String labelText;
  final String hintText;
  final String fileExtension;

  @override
  State<PickFile> createState() => _PickFileState();
}

class _PickFileState extends State<PickFile> {
  String? pickedFileName;
  File? pickedFile;

  @override
  void initState() {
    super.initState();
    pickedFileName = widget.initialUrl;
  }

  Future<void> onPickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [widget.fileExtension],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;

        pickedFile = File([file.bytes!], file.name);
        pickedFileName = pickedFile?.name;

        setState(() {});
        widget.onFilePicked(pickedFile);
      } else {
        Logger.info('파일 선택 취소');
      }
    } catch (e) {
      Logger.error('파일 선택 중 오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.labelText,
                    style: CustomTextStyles.labelLargeBlack,
                  ),
                  TextSpan(
                    text: " *",
                    style: TextStyle(color: appTheme.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 353,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusStyle.roundedBorder12,
                border: Border.all(color: appTheme.grayScale3),
                color: appTheme.white,
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 280,
                    child: Text(
                      pickedFileName ?? widget.hintText,
                      style: CustomTextStyles.bodyMediumGray,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CustomImageView(
                    imagePath: IconConstant.upload,
                    onTap: onPickFile,
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
