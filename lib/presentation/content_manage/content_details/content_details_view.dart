import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_controller.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_details/content_details_controller.dart';

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
                                buildTopBar(),
                                const SizedBox(height: 32),
                                buildSubHeader(),
                                const SizedBox(height: 32),
                                buildFirstContainer(),
                                const SizedBox(height: 16),
                                buildSecondContainer(),
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

  Container buildSecondContainer() {
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
              Text("기본 정보",
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
              InkWell(
                onTap: controller.goToEdit,
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
              Text('제목',
                  style: CustomTextStyles.labelMediumGray
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Text(controller.contentDetailsModel.name!,
                  style: CustomTextStyles.bodyMediumBlack),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(
            height: 24,
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
                  Text(controller.contentDetailsModel.category!,
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
                  Text(controller.contentDetailsModel.type!,
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
          const SizedBox(
            height: 24,
          ),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(
            height: 24,
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
          const SizedBox(height: 24),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(
            height: 24,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('소개', style: CustomTextStyles.labelMediumBlack),
              const SizedBox(height: 16),
              Text(controller.contentDetailsModel.intro!,
                  style: CustomTextStyles.bodyMediumBlack)
            ],
          ),
          const SizedBox(height: 24),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(height: 24),
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
                      Text('동영상 파일', style: CustomTextStyles.labelLargeGray),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          InkWell(
                            child: Text(
                              "동영상 재생",
                              style: CustomTextStyles.bodyMediumSkyBlue
                                  .copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: appTheme.skyBlue),
                            ),
                            onTap: () => SwitchNativeWeb.downloadFile(
                                url: controller.videoLink.value,
                                fileName: "download.mp4",
                                dataType: "data:video/MPEG-4"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 60),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('썸네일 파일', style: CustomTextStyles.labelLargeGray),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          InkWell(
                            child: Text(
                              "이미지 보기",
                              style: CustomTextStyles.bodyMediumSkyBlue
                                  .copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: appTheme.skyBlue),
                            ),
                            onTap: () => launchUrl(Uri.parse(
                                controller.contentDetailsModel.thumbnail!)),
                          ),
                          const SizedBox(width: 4),
                          CustomImageView(
                            onTap: () => SwitchNativeWeb.downloadFile(
                                url: controller.thumbnailLink.value,
                                fileName: "download.jpg",
                                dataType: "data:image/jpeg"),
                            imagePath: IconConstant.download,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 60),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('자막 파일', style: CustomTextStyles.labelLargeGray),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          InkWell(
                            child: Text(
                              "파일 보기",
                              style: CustomTextStyles.bodyMediumSkyBlue
                                  .copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: appTheme.skyBlue),
                            ),
                            onTap: () => launchUrl(
                                Uri.parse(controller.contentDetailsModel.cc!)),
                          ),
                          const SizedBox(width: 4),
                          CustomImageView(
                            onTap: () => SwitchNativeWeb.downloadFile(
                                url: controller.ccLink.value,
                                fileName: "download.txt",
                                dataType: "data:text/txt"),
                            imagePath: IconConstant.download,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildSubHeader() {
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

  TobBarSearch buildTopBar() {
    return TobBarSearch(
      name: "콘텐츠 상세",
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}
