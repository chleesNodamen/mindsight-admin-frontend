import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_register/practice_register_controller.dart';
import 'package:mindsight_admin_page/widgets/select_content_widget.dart';

class PracticeRegisterView extends GetWidget<PracticeRegisterController> {
  const PracticeRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBodyBehindAppBar: true,
        body: PageLoadingIndicator(
          isLoading: controller.isLoading.value,
          child: controller.isInited.value
              ? ResponsiveWidget(
                  largeScreen: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SideMenu(),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildTitle(),
                              const SizedBox(height: 32),
                              _buildSubMenu(),
                              const SizedBox(height: 32),
                              _buildSelectContent()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Column _buildSelectContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "콘텐츠 등록 ", style: CustomTextStyles.labelLargeBlack),
              TextSpan(text: "*", style: TextStyle(color: appTheme.red))
            ])),
            const SizedBox(height: 8),
            SelectContentWidget(
                category: ContentCategory.body,
                onSelected: controller.onSelectBody),
            const SizedBox(height: 8),
            SelectContentWidget(
                category: ContentCategory.breath,
                onSelected: controller.onSelectBreath),
            const SizedBox(height: 44),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomElevatedButton(
                  text: '저장',
                  buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
                  buttonStyle: CustomButtonStyles.fillPrimary,
                  width: 90,
                  height: 44,
                  onPressed: () async => {
                    await controller.onSave(),
                  },
                ),
                CustomElevatedButton(
                  text: '취소',
                  buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
                  buttonStyle: CustomButtonStyles.fillRedTransparent,
                  margin: const EdgeInsets.only(left: 16),
                  width: 90,
                  height: 44,
                  onPressed: () =>
                      Get.offAllNamed(AppRoutes.contentPracticeManage),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
          onTap: () => Get.offAllNamed(AppRoutes.contentPracticeManage),
          child: Text("Practice plan 관리",
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              )),
        ),
        CustomImageView(
          width: 20,
          height: 20,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          imagePath: IconConstant.arrowRight,
        ),
        Text("Practice plan 신규 등록", style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Practice plan 신규 등록",
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}
