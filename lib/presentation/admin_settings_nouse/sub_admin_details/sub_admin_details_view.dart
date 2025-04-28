import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/admin_settings_nouse/sub_admin_details/sub_admin_details_controller.dart';

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
                          margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildTitle(),
                              const SizedBox(height: 32),
                              _buildSubMenu(),
                              const SizedBox(height: 32),
                              _buildInfo()
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

  Widget _buildInfo() {
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
              Text("Admin basic info".tr,
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
              InkWell(
                onTap: controller.onEdit,
                child: Text("Edit".tr,
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
                  Text('ID'.tr,
                      style: CustomTextStyles.labelMediumGray
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text(controller.adminDetailsModel.email!,
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
                  Text('Department'.tr,
                      style: CustomTextStyles.labelMediumGray
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text(controller.adminDetailsModel.department!,
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
                  Text('Permission'.tr,
                      style: CustomTextStyles.labelMediumGray
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text(controller.adminDetailsModel.role!,
                      style: CustomTextStyles.bodyMediumBlack
                          .copyWith(fontWeight: FontWeight.w600)),
                ],
              )
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Manager'.tr,
                      style: CustomTextStyles.labelMediumGray
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text(controller.adminDetailsModel.manager!,
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
                  Text('Contact number'.tr,
                      style: CustomTextStyles.labelMediumGray
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text(controller.adminDetailsModel.phone!,
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
                  Text('Email address'.tr,
                      style: CustomTextStyles.labelMediumGray
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text(controller.adminDetailsModel.adminEmail!,
                      style: CustomTextStyles.bodyMediumBlack
                          .copyWith(fontWeight: FontWeight.w600)),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadiusStyle.roundedBorder12,
                color: appTheme.background),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Recent activity'.tr,
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
                Text(
                    controller.adminDetailsModel.lastActivity != null
                        ? DateFormat('yyyy-MM-dd-HH:mm:ss')
                            .format(controller.adminDetailsModel.lastActivity!)
                        : "",
                    style: CustomTextStyles.labelLargeGray
                        .copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Get.offAllNamed(AppRoutes.subAdminSettings);
          },
          child: Text("Sub admin management".tr,
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
        Text("관리자 Details".tr, style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "관리자 Details".tr,
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}
