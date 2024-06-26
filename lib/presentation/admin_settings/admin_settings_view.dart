import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/admin_settings_controller.dart';

class AdminSettingsView extends GetWidget<AdminSettingsController> {
  const AdminSettingsView({super.key});

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
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(48.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  buildTopBar(),
                                  const SizedBox(height: 32),
                                  _buildFirstContainer(),
                                  const SizedBox(height: 16),
                                  _buildSecondContainer(),
                                ],
                              ),
                            ),
                          ],
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

  TobBarSearch buildTopBar() {
    return const TobBarSearch(
      name: "내 계정 관리",
      searchShow: false,
      memberShow: false,
      memberCount: 0,
      searchText: '',
      viewNumber: 0,
      viewCount: false,
    );
  }

  Widget _buildFirstContainer() {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      // height: 340,
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("관리자 기본 정보", style: CustomTextStyles.labelLargeBlack),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('아이디', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text("ms_content@nodamen.com",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('담당 부서', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text("Mindsight Content Dept.",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('권한', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text("마스터 (변경불가)", style: CustomTextStyles.bodyLargeBlack),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('담당자', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text("이진아", style: CustomTextStyles.bodyLargeBlack),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('연락처', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text("01012345678", style: CustomTextStyles.bodyLargeBlack),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이메일주소', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text("jalee@nodamen.com",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: appTheme.background),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('최근 활동', style: CustomTextStyles.labelLargeGray),
                const SizedBox(
                  width: 8,
                ),
                Container(
                    height: 14,
                    width: 1,
                    decoration: BoxDecoration(color: appTheme.grayScale3)),
                const SizedBox(
                  width: 8,
                ),
                Text('2024-03-13-10:09:34',
                    style: CustomTextStyles.labelLargeGray),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _buildSecondContainer() {
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
            color: appTheme.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          // height: 1016,
          width: double.infinity,
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 32,
              ),
              Stack(alignment: Alignment.centerLeft, children: [
                CustomElevatedButton(
                  text: '저장',
                  buttonTextStyle: CustomTextStyles.bodyMediumWhite.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  buttonStyle: CustomButtonStyles.fillPrimary,
                  // margin: const EdgeInsets.symmetric(
                  //     vertical: 11, horizontal: 24),
                  width: 90,
                  height: 44,
                ),
              ])
            ],
          )),
    );
  }
}
