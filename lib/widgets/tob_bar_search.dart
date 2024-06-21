import 'package:mindsight_admin_page/app_export.dart';

class TobBarSearch extends StatelessWidget {
  const TobBarSearch({
    super.key,
    this.name,
    this.viewCount = false,
    this.searchText,
    this.searchShow = true,
  });

  final String? name;
  final bool? viewCount;
  final String? searchText;
  final bool? searchShow;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text("$name", style: CustomTextStyles.headlineLargeBlack),
            const SizedBox(
              width: 16,
            ),
            Visibility(
              visible: viewCount!,
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: IconConstant.contentFull,
                    color: appTheme.black,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text("122,878 건",
                      style: CustomTextStyles.bodyMediumGray
                          .copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
        Visibility(
          visible: searchShow!,
          child: Row(
            children: [
              SizedBox(
                height: 45,
                width: 266,
                child: TextFormField(
                  // controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: searchText,
                    labelStyle: CustomTextStyles.bodyMediumGray,
                    // floatingLabelStyle: TextStyle(color: appTheme.black),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    // hintText: "abc@domain.com",
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                      borderSide: BorderSide(
                        color: appTheme.grayScale3,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                      borderSide: BorderSide(
                        color: appTheme.grayScale3,
                        width: 1,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                      borderSide: BorderSide(
                        color: appTheme.grayScale3,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                      borderSide: BorderSide(
                        color: appTheme.grayScale3,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                      borderSide: BorderSide(
                        color: appTheme.red,
                        width: 2,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                      borderSide: BorderSide(
                        color: appTheme.red,
                        width: 2,
                      ),
                    ),
                    errorStyle: TextStyle(
                        color: appTheme.red,
                        fontSize: 12.fSize,
                        fontWeight: FontWeight.w500),
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
                    onTap: () {},
                    child: Text("검색", style: CustomTextStyles.bodyMediumWhite)),
              )
            ],
          ),
        )
      ],
    );
  }
}
