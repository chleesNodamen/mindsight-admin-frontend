import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/gender.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_details/master_details_controller.dart';
import 'package:mindsight_admin_page/widgets/label_image.dart';
import 'package:mindsight_admin_page/widgets/label_value.dart';
import 'package:mindsight_admin_page/widgets/verified_label_value.dart';

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
                                children: [
                                  _buildTitle(),
                                  if (Account.isAdmin) ...[
                                    const SizedBox(height: 16),
                                    _buildSubMenu(),
                                  ],
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
        CustomImageView(imagePath: IconConstant.arrowRight),
        Text("Master details".tr, style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: Account.isAdmin ? "Master details".tr : "My account detail".tr,
      searchShow: false,
      viewCount: false,
    );
  }

  Widget _buildInfo() {
    final model = controller.masterDetailModel;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder12,
        color: appTheme.white,
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    decorationColor: appTheme.skyBlue,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              LabelValue(label: "ID", value: model.email!),
              LabelValue(label: "Nickname", value: model.nickname!),
              LabelValue(
                label: "Join Date",
                value: DateFormat('yyyy-MM-dd').format(model.createdAt!),
              ),
            ],
          ),
          Divider(height: 49, thickness: 1, color: appTheme.grayScale2),
          Text("Basic info".tr, style: CustomTextStyles.labelLargeBlack),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelValue(label: "First name", value: model.name!),
              LabelValue(label: "Last name", value: model.lastName ?? ""),
              LabelValue(
                  label: "Gender",
                  value: Gender.fromKeyword(model.gender)?.displayName ?? ""),
              LabelValue(label: "Year of birth", value: model.birthDate ?? ""),
            ],
          ),
          Divider(height: 49, thickness: 1, color: appTheme.grayScale2),
          Row(
            children: [
              VerifiedLabelValue(
                  label: "Email address", value: model.email!, width: 230 * 2),
              VerifiedLabelValue(
                  label: "Mobile Number",
                  value: model.phoneNumber ?? "",
                  width: 230 * 2),
            ],
          ),
          Divider(height: 49, thickness: 1, color: appTheme.grayScale2),
          Row(
            children: [
              LabelImage(
                  label: "Photo", url: model.photoUrl!, isCircular: false),
              LabelImage(label: "ID Card", url: model.idPhotoUrl!),
            ],
          ),
          Divider(height: 49, thickness: 1, color: appTheme.grayScale2),
          Row(
            children: [
              LabelValue(
                  label: "Country", value: controller.contry.displayName.tr),
              LabelValue(label: "Address", value: model.address ?? ""),
              LabelValue(
                  label: "Primary Language",
                  value: controller.primaryLanguage.displayName.tr),
              LabelValue(
                  label: "Secondary Language",
                  value: controller.secondaryLanguage.displayName.tr),
            ],
          ),
          Divider(height: 49, thickness: 1, color: appTheme.grayScale2),
          Row(
            children: [
              Expanded(
                child: LabelValue(label: "Introduction", value: model.intro!),
              ),
            ],
          ),
          Divider(height: 49, thickness: 1, color: appTheme.grayScale2),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder12,
              color: appTheme.background,
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text("Recent activity".tr,
                    style: CustomTextStyles.labelLargeGray),
                const SizedBox(width: 8),
                Container(height: 14, width: 1, color: appTheme.grayScale3),
                const SizedBox(width: 8),
                Text("", style: CustomTextStyles.labelLargeGray),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text("Company info".tr, style: CustomTextStyles.labelLargeBlack),
          const SizedBox(height: 24),
          Row(
            children: [
              LabelValue(label: "Company name", value: model.companyName ?? ""),
              LabelValue(
                  label: "Representative", value: model.representative ?? ""),
              LabelValue(
                  label: "Business number", value: model.businessNumber ?? ""),
              LabelValue(label: "Phone", value: model.companyPhone ?? ""),
            ],
          ),
          Divider(height: 49, thickness: 1, color: appTheme.grayScale2),
          Row(
            children: [
              LabelValue(label: "Contact name", value: model.contactName ?? ""),
              LabelValue(
                  label: "Contact email", value: model.contactEmail ?? ""),
              LabelValue(
                  label: "Contact phone", value: model.contactPhone ?? ""),
              LabelValue(label: "Address", value: model.contactAddress ?? ""),
            ],
          ),
        ],
      ),
    );
  }
}
