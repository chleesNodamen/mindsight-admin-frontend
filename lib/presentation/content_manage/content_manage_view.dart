import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_controller.dart';

class ContentManageView extends GetWidget<ContentManageController> {
  const ContentManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TobBarSearch(
            name: "콘텐츠 목록",
            searchShow: true,
            viewCount: true,
          ),
          const SizedBox(height: 32),
          CustomElevatedButton(
            text: "신규 등록",
            height: 44,
            width: 107,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          ),
          const SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
              color: appTheme.white,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            height: 268,
            width: double.infinity,
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('타입', style: CustomTextStyles.labelMediumGray),
                Expanded(
                  child: Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            // padding:
                            // const EdgeInsets.only(left: 12, bottom: 12),
                            itemCount: controller.showMore.value ? 12 : 8,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Row(
                                  children: <Widget>[
                                    Checkbox(
                                      value: controller.checkboxValues[index],
                                      onChanged: (value) {
                                        controller.checkboxValues[index] =
                                            value!;
                                      },
                                    ),
                                    Text('Checkbox $index',
                                        style:
                                            CustomTextStyles.bodyMediumBlack),
                                  ],
                                ),
                                onTap: () {
                                  controller.checkboxValues[index] =
                                      !controller.checkboxValues[index];
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: !controller.showMore.value,
                    child: GestureDetector(
                      child: Text(
                        "전체 보기",
                        style: CustomTextStyles.bodySmallSkyBlue.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                        controller.showMore.value = true;
                      },
                    ),
                  ),
                ),
                const Divider(),
                Text('타입', style: CustomTextStyles.labelMediumGray),
                // Obx(
                //     () => Row(
                //       children: [
                //         Expanded(
                //           child: ListView.builder(
                //             scrollDirection: Axis.horizontal,
                //             // shrinkWrap: true,
                //             // padding:
                //             // const EdgeInsets.only(left: 12, bottom: 12),
                //             itemCount: 2,
                //             itemBuilder: (context, index) {
                //               return GestureDetector(
                //                 child: Row(
                //                   children: <Widget>[
                //                     Checkbox(
                //                       value: controller.checkboxValues[index],
                //                       onChanged: (value) {
                //                         controller.checkboxValues[index] =
                //                             value!;
                //                       },
                //                     ),
                //                     Text('Checkbox $index',
                //                         style:
                //                             CustomTextStyles.bodyMediumBlack),
                //                   ],
                //                 ),
                //                 onTap: () {
                //                   controller.checkboxValues[index] =
                //                       !controller.checkboxValues[index];
                //                 },
                //               );
                //             },
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
