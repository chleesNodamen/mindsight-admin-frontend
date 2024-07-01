import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_details/sub_admin_details_controller.dart';

class SubAdminDetailsView extends GetWidget<SubAdminDetailsController> {
  const SubAdminDetailsView({super.key});

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
                          margin: const EdgeInsets.all(48.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildTopBar(),
                              const SizedBox(height: 32),
                              buildSubHeader(),
                              const SizedBox(height: 32),
                              buildFirstContainer()
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

  Widget buildFirstContainer() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("관리자 기본 정보",
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
              GestureDetector(
                onTap: controller.goToEdit,
                child: Text("수정",
                    style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: appTheme.skyBlue)),
              )
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('아이디',
                      style: CustomTextStyles.labelMediumGray
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text("ms_content@nodamen.com",
                      style: CustomTextStyles.bodyMediumBlack
                          .copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('담당 부서',
                      style: CustomTextStyles.labelMediumGray
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text("Mindsight Content Dept.",
                      style: CustomTextStyles.bodyMediumBlack
                          .copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('권한',
                      style: CustomTextStyles.labelMediumGray
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text("마스터 (변경불가)",
                      style: CustomTextStyles.bodyMediumBlack
                          .copyWith(fontWeight: FontWeight.w600)),
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
                  Text('담당자',
                      style: CustomTextStyles.labelMediumGray
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text("이진아",
                      style: CustomTextStyles.bodyMediumBlack
                          .copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('연락처',
                      style: CustomTextStyles.labelMediumGray
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text("01012345678",
                      style: CustomTextStyles.bodyMediumBlack
                          .copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이메일주소',
                      style: CustomTextStyles.labelMediumGray
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text("jalee@nodamen.com",
                      style: CustomTextStyles.bodyMediumBlack
                          .copyWith(fontWeight: FontWeight.w600)),
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
                Text('최근 활동',
                    style: CustomTextStyles.labelLargeGray
                        .copyWith(fontWeight: FontWeight.w600)),
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
                    style: CustomTextStyles.labelLargeGray
                        .copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buildSubHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Text("관리자 등록",
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
        Text("관리자 상세", style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch buildTopBar() {
    return TobBarSearch(
      name: "관리자 상세",
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}
