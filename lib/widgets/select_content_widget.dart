import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/function/show_content_select_dialog.dart';

typedef OnSelected = void Function(String? name, String? id);

// ignore: must_be_immutable
class SelectContentWidget extends StatefulWidget {
  String? initialName;
  final ContentCategory category;
  final OnSelected onSelected;

  SelectContentWidget({
    super.key,
    this.initialName,
    required this.category,
    required this.onSelected,
  });

  @override
  State<SelectContentWidget> createState() => _SelectContentWidgetState();
}

class _SelectContentWidgetState extends State<SelectContentWidget> {
  // String selectedName = '';

  @override
  void initState() {
    super.initState();
    // selectedName = widget.initialName ?? '';
  }

  Future<void> _selectContent() async {
    var result = await showContentSelectDialog(widget.category);

    if (result != null) {
      setState(() {
        // selectedName = result["name"]!;
        widget.initialName = result["name"]!;
      });
      widget.onSelected(result["name"], result["id"]);
    } else {
      widget.onSelected(null, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _selectContent,
      child: Container(
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
            Text(
              // selectedName.isNotEmpty ? selectedName : "",
              widget.initialName ?? "",
              style: CustomTextStyles.bodyMediumBlack,
            ),
            CustomImageView(
              imagePath: IconConstant.search,
            ),
          ],
        ),
      ),
    );
  }
}
