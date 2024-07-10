import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';

class TobBarSearch extends StatelessWidget {
  TobBarSearch({
    super.key,
    this.name,
    this.viewCount = false,
    this.viewNumber = 122878,
    this.memberShow = false,
    this.memberCount = 0,
    this.searchText,
    this.searchShow = true,
    this.onSearch,
  });

  final String? name;
  final bool? viewCount;
  final int? viewNumber;
  final bool? memberShow;
  final int? memberCount;
  final String? searchText;
  final bool? searchShow;
  final TextEditingController textController = TextEditingController();
  final Future<void> Function(String? search)? onSearch;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("$name", style: CustomTextStyles.headlineLargeBlack),
            const SizedBox(
              width: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Visibility(
                visible: viewCount! || memberShow!,
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: viewCount!
                          ? IconConstant.contentFull
                          : IconConstant.user,
                      color: appTheme.black,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                        viewCount!
                            ? "${NumberFormat('#,###').format(viewNumber)} 건"
                            : "${NumberFormat('#,###').format(memberCount)} 명",
                        style: CustomTextStyles.bodyMediumGray
                            .copyWith(fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: searchShow!,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: appTheme.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                ),
                height: 45,
                width: 266,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.start,
                  controller: textController,
                  decoration: InputDecoration(
                    labelText: searchText,
                    labelStyle: CustomTextStyles.bodyMediumGray,
                    // floatingLabelStyle: TextStyle(color: appTheme.black),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    // hintText: "abc@domain.com",
                  ),
                ),
              ),
              Container(
                width: 76,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: appTheme.black,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )),
                child: InkWell(
                    onTap: () {
                      onSearch != null ? onSearch!(textController.text) : null;
                    },
                    child: Text("검색", style: CustomTextStyles.bodyMediumWhite)),
              )
            ],
          ),
        )
      ],
    );
  }
}
