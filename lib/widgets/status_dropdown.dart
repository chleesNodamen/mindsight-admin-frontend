import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindsight_admin_page/theme/app_decoration.dart';
import 'package:mindsight_admin_page/theme/theme_helper.dart';

class StatusDropdown extends StatelessWidget {
  final bool isEnable;
  final bool isActive;
  final ValueChanged<bool>? onChanged;
  final BorderRadius borderRadius;
  final TextStyle activeTextStyle;
  final TextStyle inactiveTextStyle;

  const StatusDropdown({
    super.key,
    required this.isEnable,
    required this.isActive,
    this.onChanged,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.activeTextStyle = const TextStyle(color: Colors.green, fontSize: 16),
    this.inactiveTextStyle = const TextStyle(color: Colors.red, fontSize: 16),
  });

  @override
  Widget build(BuildContext context) {
    if (isEnable) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: appTheme.white,
          borderRadius: BorderRadiusStyle.roundedBorder8,
          border: Border.all(
            width: 1,
            color: appTheme.grayScale2,
          ),
        ),
        child: DropdownButton<String>(
          value: isActive ? '활성'.tr : '비활성'.tr,
          underline: Container(),
          padding: const EdgeInsets.only(left: 12),
          borderRadius: borderRadius,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: (String? newValue) {
            if (newValue != null && onChanged != null) {
              onChanged!(newValue == '활성'.tr);
            }
          },
          items: <String>['활성'.tr, '비활성'.tr]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: value == "활성".tr ? activeTextStyle : inactiveTextStyle,
              ),
            );
          }).toList(),
        ),
      );
    } else {
      return Text(
        isActive ? '활성'.tr : '비활성'.tr,
        style: isActive ? activeTextStyle : inactiveTextStyle,
      );
      // Container(
      //   padding: const EdgeInsets.only(left: 6, right: 6, top: 12, bottom: 12),
      //   decoration: BoxDecoration(
      //     borderRadius: borderRadius,
      //     border: Border.all(color: Colors.grey),
      //   ),
      //   child: Text(
      //     isActive ? '활성' : '비활성',
      //     style: isActive ? activeTextStyle : inactiveTextStyle,
      //   ),
      // );
    }
  }
}
