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
          const TopBarSearch(
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
            height: 268,
            width: double.infinity,
            margin: const EdgeInsets.all(32.0),
            child: Obx(
              () => GestureDetector(
                child: Row(
                  children: <Widget>[
                    Checkbox(
                        value: controller.removeButton.value,
                        onChanged: (a) {
                          controller.removeButton.value =
                              !controller.removeButton.value;
                        }),
                    Text('Remove Button',
                        style: CustomTextStyles.bodyMediumBlack)
                  ],
                ),
                onTap: () {
                  controller.removeButton.value =
                      !controller.removeButton.value;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
