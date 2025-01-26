import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_details/content_details_controller.dart';
import 'package:mindsight_admin_page/widgets/image_actions_widget.dart';
import 'package:mindsight_admin_page/widgets/video_actions_widget.dart';

class ContentDetailsView extends GetWidget<ContentDetailsController> {
  const ContentDetailsView({super.key});

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
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _buildTitle(),
                                const SizedBox(height: 32),
                                _buildSubMenu(),
                                const SizedBox(height: 32),
                                _buildInfo(),
                                const SizedBox(height: 16),
                                _buildUserData(),
                              ],
                            ),
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

  Container _buildUserData() {
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
          Text("User data".tr, style: CustomTextStyles.labelLargeBlack),
          const SizedBox(height: 24),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(controller.contentDetailsModel.seen!.toString(),
                      style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("Views".tr, style: CustomTextStyles.labelLargeGray)
                ],
              ),
              const SizedBox(width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(controller.contentDetailsModel.liked!.toString(),
                      style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("Likes".tr, style: CustomTextStyles.labelLargeGray)
                ],
              ),
            ],
          )
        ],
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
              Text("Basic info".tr, style: CustomTextStyles.labelLargeBlack),
              InkWell(
                onTap: controller.onEdit,
                child: Text("Edit".tr,
                    style: CustomTextStyles.labelLargeSkyBlue
                        .copyWith(decoration: TextDecoration.underline)),
              )
            ],
          ),
          const SizedBox(height: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title'.tr, style: CustomTextStyles.labelMediumGray),
              const SizedBox(height: 16),
              Text(controller.contentDetailsModel.name!,
                  style: CustomTextStyles.bodyMediumBlack),
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
                  Text('Category'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      ContentCategory.fromKeyword(
                              controller.contentDetailsModel.category!)
                          .displayName
                          .tr,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text('Type'.tr, style: CustomTextStyles.labelMediumGray),
              //     const SizedBox(height: 16),
              //     Text('', style: CustomTextStyles.bodyMediumBlack),
              //   ],
              // ),
              // const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Master'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.contentDetailsModel.master!,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Level'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      '${ContentLevel.fromKeyword(controller.contentDetailsModel.level)?.displayName.tr}',
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Target Language'.tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      ContentLanguage.fromKeyword(
                              controller.contentDetailsModel.targetLanguage!)
                          .displayName
                          .tr,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Approval status'.tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      ContentStatus.fromKeyword(
                              controller.contentDetailsModel.status!)
                          .displayName
                          .tr,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Exposure Status'.tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      ContentExposure.fromKeyword(
                              controller.contentDetailsModel.exposure!)
                          .displayName
                          .tr,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tags".tr, style: CustomTextStyles.labelMediumGray),
              const SizedBox(height: 16),
              Text(controller.contentDetailsModel.tags!.join(', '),
                  style: CustomTextStyles.bodyMediumBlack),
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Introduction'.tr, style: CustomTextStyles.labelMediumGray),
              const SizedBox(height: 16),
              Text(controller.contentDetailsModel.intro!,
                  style: CustomTextStyles.bodyMediumBlack)
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("File".tr, style: CustomTextStyles.labelLargeBlack),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Media File'.tr,
                          style: CustomTextStyles.labelMediumGray),
                      const SizedBox(height: 16),
                      VideoActionsWidget(
                          videoUrl: controller.contentDetailsModel.video!)
                    ],
                  ),
                  const SizedBox(width: 60),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Thumbnail file'.tr,
                          style: CustomTextStyles.labelMediumGray),
                      const SizedBox(height: 16),
                      ImageActionsWidget(
                        imageUrl: controller.contentDetailsModel.thumbnail!,
                      ),
                    ],
                  ),
                  // const SizedBox(width: 60),
                ],
              ),
            ],
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
            Get.offAllNamed(AppRoutes.contentManage);
          },
          child: Text("Content list".tr,
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
        Text("Content Details".tr, style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Content Details".tr,
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}
