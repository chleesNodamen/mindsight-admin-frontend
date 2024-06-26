import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_edit_controller.dart';

class MemberEditView extends GetWidget<MemberEditController> {
  const MemberEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        extendBodyBehindAppBar: true,
        body: ResponsiveWidget(
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
                          const TobBarSearch(
                            name: "사전 정보 수정",
                            searchShow: false,
                            viewCount: false,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              GestureDetector(
                                child: Text(
                                  "회원 목록",
                                  style: CustomTextStyles.bodyMediumSkyBlue
                                      .copyWith(
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                    decorationColor: appTheme.skyBlue,
                                  ),
                                ),
                                onTap: () => Get.back(), //TODO edit
                              ),
                              CustomImageView(
                                imagePath: IconConstant.arrowRight,
                              ),
                              GestureDetector(
                                child: Text(
                                  "회원 상세",
                                  style: CustomTextStyles.bodyMediumSkyBlue
                                      .copyWith(
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                    decorationColor: appTheme.skyBlue,
                                  ),
                                ),
                                onTap: () => Get.back(),
                              ),
                              CustomImageView(
                                imagePath: IconConstant.arrowRight,
                              ),
                              Text('사전 정보 수정',
                                  style: CustomTextStyles.bodyMediumGray),
                            ],
                          ),
                          const SizedBox(height: 32),
                          _companySelect(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      
    );
  }

  Widget _companySelect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('소속', style: CustomTextStyles.labelLargeBlack),
        const SizedBox(height: 8),
        DecoratedBox(
          decoration: BoxDecoration(
            color: appTheme.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: appTheme.grayScale2,
            ),
          ),
          child: DropdownButton<String>(
            value: 'Nodamen',
            underline: Container(),
            padding: const EdgeInsets.only(left: 16),
            borderRadius: BorderRadius.circular(12),
            elevation: 16,
            style: CustomTextStyles.bodyMediumBlack,
            onChanged: (String? newValue) {
              //TODO
            },
            items: controller.membershipLabels
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: CustomTextStyles.bodyMediumBlack,
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
