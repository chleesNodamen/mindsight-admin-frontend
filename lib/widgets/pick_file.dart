import 'package:file_picker/file_picker.dart';
import 'package:universal_html/html.dart';
import 'package:mindsight_admin_page/app_export.dart';

class PickFileFormField extends FormField<String?> {
  PickFileFormField(
      {super.key,
      String? initialUrl,
      required void Function(File? pickedFile) onFilePicked,
      required String labelText,
      required bool essential,
      required String hintText,
      required List<String> fileExtension,
      String? toolTip})
      : super(
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
                state.didChange(file!.name);
              },
              labelText: labelText,
              toolTip: toolTip,
              essential: essential,
              hintText: hintText,
              fileExtension: fileExtension,
              errorText: state.errorText,
            );
          },
        );
}

class PickFile extends StatefulWidget {
  const PickFile({
    super.key,
    this.initialUrl,
    this.toolTip,
    required this.onFilePicked,
    required this.labelText,
    required this.hintText,
    required this.fileExtension,
    required this.essential,
    this.errorText,
  });

  final String? initialUrl;
  final void Function(File? pickedFile) onFilePicked;
  final String labelText;
  final String? toolTip;
  final bool essential;
  final String hintText;
  final List<String> fileExtension;
  final String? errorText;

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
        allowedExtensions: widget.fileExtension,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;

        pickedFile = File([file.bytes!], file.name);
        pickedFileName = pickedFile?.name;

        setState(() {});
        widget.onFilePicked(pickedFile);
      } else {
        Logger.info('File 선택 Cancel'.tr);
      }
    } catch (e) {
      Logger.error('File 선택 중 오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    style: CustomTextStyles.labelLargeBlack,
                  ),
                  TextSpan(
                    text: widget.essential ? " *" : "",
                    style: TextStyle(color: appTheme.red),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            widget.toolTip == null
                ? const SizedBox.shrink()
                : Tooltip(
                    message: widget.toolTip,
                    // preferBelow: false,
                    // verticalOffset: -60,
                    // margin: const EdgeInsets.only(left: 265),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    triggerMode: TooltipTriggerMode.tap,
                    decoration: BoxDecoration(
                      color: appTheme.grayScale8,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    // child: IconButton(
                    //   icon: const Icon(Icons.help_outline),
                    //   onPressed: () {},
                    // ),
                    child: const Icon(Icons.help_outline)),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: 353,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // border: Border.all(color: appTheme.grayScale3),
            border: Border.all(
              color:
                  widget.errorText != null ? Colors.red : appTheme.grayScale3,
            ),
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
