import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_details_controller.dart';
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
                                  TobBarSearch(
                                    name: "마스터 상세",
                                    searchShow: false,
                                    viewCount: false,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      InkWell(
                                        child: Text(
                                          "마스터 목록",
                                          style: CustomTextStyles
                                              .bodyMediumSkyBlue
                                              .copyWith(
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline,
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
                                      Text('마스터 상세',
                                          style:
                                              CustomTextStyles.bodyMediumGray),
                                    ],
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
              Text('계정 정보', style: CustomTextStyles.labelLargeBlack),
              InkWell(
                  onTap: controller.onMasterEdit,
                  child: Text(
                    '수정',
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
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('이메일 주소 (아이디)', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("mrlee@nodamen.com",
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
                  Text('닉네임', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("chlees", style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Text('기본 정보', style: CustomTextStyles.labelLargeBlack),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('이름', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("이충헌", style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('사진', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  const ImageActionsWidget(
                      imageUrl:
                          "https://cdn.mindsight.im/release/9c22a3e0-9856-11ef-b9ba-6536e645bda9.jpg")
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('핸드폰 번호', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("010-1111-2222",
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
                  Text('신분증', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  const ImageActionsWidget(
                      imageUrl:
                          "https://cdn.mindsight.im/release/9c22a3e0-9856-11ef-b9ba-6536e645bda9.jpg")
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
                  Text('국가', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("대한민국", style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('주소', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("대한민국 서울시 강남구 강남타워",
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
                  Text('제1언어', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("영어", style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('제2언어', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("한국어", style: CustomTextStyles.bodyMediumBlack),
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
                  Text('자기소개', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("안녕하세요! 명상 강사 이미래 입니다!",
                      style: CustomTextStyles.bodyMediumBlack),
                ],
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
                Text(
                    controller.membersDataModel.lastLogin != null
                        ? DateFormat('yyyy-MM-dd-HH:mm:ss')
                            .format(controller.membersDataModel.lastLogin!)
                        : controller.dash,
                    style: CustomTextStyles.labelLargeGray),
              ],
            ),
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Text('회사 정보', style: CustomTextStyles.labelLargeBlack),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('회사 이름', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("노다멘", style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('대표자', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("이원준", style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('사업자 번호', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("11111111-111111111",
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
                  Text('전화', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("02-1111-2222", style: CustomTextStyles.bodyMediumBlack),
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
                  Text('담당자 명', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("이미래", style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('담당자 이메일', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("mrlee@nodamen.com",
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
                  Text('담당자 전화번호', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("02-1111-2222", style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('주소', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("대한민국 서울시 강남구 강남타워",
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
