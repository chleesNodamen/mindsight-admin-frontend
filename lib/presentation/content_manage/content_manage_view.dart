import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_controller.dart';

class ContentManageView extends GetWidget<ContentManageController> {
  const ContentManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: const EdgeInsets.all(48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TobBarSearch(
                name: "콘텐츠 목록",
                searchShow: true,
                viewCount: true,
                searchText: "제목, 마스터 이름, 태그 검색",
              ),
              const SizedBox(height: 32),
              CustomElevatedButton(
                text: "신규 등록",
                height: 44,
                width: 107,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
              ),
              const SizedBox(height: 32),
              buildFirstContainer(),
              dropdownButton()
            ],
          ),
        ));
  }

  DropdownButton<String> dropdownButton() {
    return DropdownButton<String>(
      value: controller.selectedOrder.value,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        if (newValue != null) {
          controller.updateSelectedOrder(newValue);
        }
      },
      items: <String>['등록순', '조회순', '좋아요순']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Container buildFirstContainer() {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      height: controller.showMore.value ? 308 : 268,
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('타입', style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 17),
          SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      runSpacing: 18,
                      children: List.generate(3, (index) {
                        return CustomCheckboxWidget(
                          isChecked: controller.checkboxValues[index],
                          label: controller.checkboxLabels[index],
                          onChanged: (value) =>
                              controller.toggleCheckbox(index, value),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      runSpacing: 18,
                      children: List.generate(
                        controller.checkboxValues.length - 3,
                        (index) {
                          int checkboxIndex = index + 3;
                          return CustomCheckboxWidget(
                            isChecked: controller.checkboxValues[checkboxIndex],
                            label: controller.checkboxLabels[checkboxIndex],
                            onChanged: (value) =>
                                controller.toggleCheckbox(checkboxIndex, value),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    child: Text(
                      controller.showMore.value ? "간략히 보기" : "전체 보기",
                      style: CustomTextStyles.bodySmallSkyBlue.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: appTheme.skyBlue,
                      ),
                    ),
                    onTap: () {
                      controller.showMore.value = !controller.showMore.value;
                      controller.addMoreCheckboxes();
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(
            height: 24,
          ),
          Text('상태', style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 15),
          Row(
            children: [
              CustomCheckboxWidget(
                isChecked: controller.isChecked.value,
                label: '정상',
                onChanged: (value) => controller.toggleSecondCheckbox(
                    0, value), // Adjust as needed
              ),
              CustomCheckboxWidget(
                isChecked: controller.isChecked.value,
                label: '서비스 안함',
                onChanged: (value) => controller.toggleSecondCheckbox(
                    1, value), // Adjust as needed
              ),
            ],
          ),
        ],
      ),
    );
  }
}
