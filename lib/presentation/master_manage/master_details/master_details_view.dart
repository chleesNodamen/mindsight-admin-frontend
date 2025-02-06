import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_details/master_details_controller.dart';
import 'package:mindsight_admin_page/widgets/image_actions_widget.dart';

class MasterDetailsView extends GetWidget<MasterDetailsController> {
  const MasterDetailsView({super.key});

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
                              margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildTitle(),
                                  Visibility(
                                    visible: Account.isAdmin,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 16),
                                        _buildSubMenu(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  _buildInfo(),
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

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
          child: Text(
            "Master list".tr,
            style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: appTheme.skyBlue,
            ),
          ),
          onTap: () {
            controller.onMasterList();
          },
        ),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text("Master Details".tr, style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: Account.isAdmin ? "Master Details".tr : "My account detail".tr,
      searchShow: false,
      viewCount: false,
    );
  }

  Widget _buildInfo() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder12,
          color: appTheme.white),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Account Information".tr,
                  style: CustomTextStyles.labelLargeBlack),
              InkWell(
                  onTap: controller.onMasterEdit,
                  child: Text(
                    "Edit".tr,
                    style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: appTheme.skyBlue),
                  ))
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("ID".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.masterDetailModel.email,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Nickname".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.masterDetailModel.nickname,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Text("Basic info".tr, style: CustomTextStyles.labelLargeBlack),
          const SizedBox(
            height: 24,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Name".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.masterDetailModel.name,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Photo".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  ImageActionsWidget(
                    imageUrl: controller.masterDetailModel.photoUrl!,
                    isCircular: true,
                  )
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Mobile Number".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.masterDetailModel.phoneNumber,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("ID Card".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  ImageActionsWidget(
                      imageUrl: controller.masterDetailModel.idPhotoUrl!)
                ],
              ),
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Country".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.contry.displayName.tr,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Address".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.masterDetailModel.address,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Primary Language".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.primaryLanguage.displayName.tr,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Secondary Language".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.secondaryLanguage.displayName.tr,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Introduction".tr,
                        style: CustomTextStyles.labelMediumGray),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      controller.masterDetailModel.intro,
                      style: CustomTextStyles.bodyMediumBlack,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadiusStyle.roundedBorder12,
                color: appTheme.background),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Recent activity".tr,
                    style: CustomTextStyles.labelLargeGray),
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
                    // controller.masterDetailModel.lastLogin != null
                    //     ? DateFormat('yyyy-MM-dd-HH:mm:ss')
                    //         .format(controller.masterDetailModel.lastLogin!)
                    //     : "-",
                    "-",
                    style: CustomTextStyles.labelLargeGray),
              ],
            ),
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Text("Company info".tr, style: CustomTextStyles.labelLargeBlack),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Company name".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.masterDetailModel.companyName ?? "-",
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Representative".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.masterDetailModel.representative ?? "-",
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Business number".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.masterDetailModel.businessNumber ?? "-",
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Phone".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.masterDetailModel.companyPhone ?? "-",
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Contact name".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.masterDetailModel.contactName ?? "-",
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Contact email".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.masterDetailModel.contactEmail ?? "-",
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Contact phone".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.masterDetailModel.contactPhone ?? "-",
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Address".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.masterDetailModel.contactAddress ?? "-",
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
