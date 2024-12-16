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
          Text("사용자 데이터", style: CustomTextStyles.labelLargeBlack),
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
                  Text("조회수", style: CustomTextStyles.labelLargeGray)
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
                  Text("좋아요 수", style: CustomTextStyles.labelLargeGray)
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
              Text("기본 정보", style: CustomTextStyles.labelLargeBlack),
              InkWell(
                onTap: controller.onEdit,
                child: Text("수정",
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
              Text('제목', style: CustomTextStyles.labelMediumGray),
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
                  Text('카테고리', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      ContentCategory.fromKeyword(
                              controller.contentDetailsModel.category!)
                          .displayName,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('타입', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      '${ContentType.fromKeyword(controller.contentDetailsModel.type!)?.displayName}',
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('마스터', style: CustomTextStyles.labelMediumGray),
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
                  Text('수준', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      '${ContentLevel.fromKeyword(controller.contentDetailsModel.level)?.displayName}',
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('타겟 언어', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      ContentLanguage.fromKeyword(
                              controller.contentDetailsModel.targetLanguage!)
                          .displayName,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('승인 상태', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      ContentStatus.fromKeyword(
                              controller.contentDetailsModel.status!)
                          .displayName,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('노출 상태', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      ContentExposure.fromKeyword(
                              controller.contentDetailsModel.exposure!)
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("태그", style: CustomTextStyles.labelMediumGray),
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
              Text('소개', style: CustomTextStyles.labelMediumGray),
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
              Text("파일", style: CustomTextStyles.labelLargeBlack),
              const SizedBox(height: 24),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('미디어 파일', style: CustomTextStyles.labelMediumGray),
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
                      Text('썸네일 파일', style: CustomTextStyles.labelMediumGray),
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
          child: Text("콘텐츠 목록",
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
        Text("콘텐츠 상세", style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "콘텐츠 상세",
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}
