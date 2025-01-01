import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_details_controller.dart';

class CompanyDetailsView extends GetWidget<CompanyDetailsController> {
  const CompanyDetailsView({super.key});

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
                                  TobBarSearch(
                                    name: "회사 상세".tr,
                                    searchShow: false,
                                    viewCount: false,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildSubMenu(),
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
    if (Account.isAdmin) {
      return Row(
        children: [
          InkWell(
            child: Text(
              "회사 목록".tr,
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              ),
            ),
            onTap: () {
              controller.onList();
            },
          ),
          CustomImageView(
            imagePath: IconConstant.arrowRight,
          ),
          Text("회사 상세".tr, style: CustomTextStyles.bodyMediumGray),
        ],
      );
    } else {
      return Row(
        children: [
          InkWell(
            child: Text(
              "회사 목록".tr,
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              ),
            ),
            onTap: () {
              controller.onList();
            },
          ),
          CustomImageView(
            imagePath: IconConstant.arrowRight,
          ),
          Text("회사 상세".tr, style: CustomTextStyles.bodyMediumGray),
        ],
      );
    }
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
              Text("회사 정보".tr, style: CustomTextStyles.labelLargeBlack),
              Visibility(
                visible: Account.isMaster(
                    controller.companyDetailModel.createMasterEmail!),
                child: InkWell(
                    onTap: controller.onEdit,
                    child: Text(
                      "수정".tr,
                      style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: appTheme.skyBlue),
                    )),
              )
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
                  Text("회사 이름".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.companyDetailModel.companyName!,
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
                  Text("대표자".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.companyDetailModel.representative!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('만든 마스터'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.companyDetailModel.createMasterNickname!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('승인 상태'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      ContentStatus.fromKeyword(
                              controller.companyDetailModel.verified!)
                          .displayName,
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
                  Text("사업자 번호".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.companyDetailModel.businessNumber!,
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
                  Text("전화".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.companyDetailModel.phone!,
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
                  Text("담당자 명".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.companyDetailModel.contactName!,
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
                  Text("담당자 이메일".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.companyDetailModel.contactEmail!,
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
                  Text("담당자 전화번호".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.companyDetailModel.contactPhone!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
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
                  Text("주소".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.companyDetailModel.address!,
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
