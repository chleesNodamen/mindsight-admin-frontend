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
      return SizedBox(
        height: 32,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: appTheme.white,
            borderRadius: BorderRadiusStyle.roundedBorder8,
            border: Border.all(
              width: 1,
              color: appTheme.grayScale2,
            ),
          ),
          child: DropdownButton<String>(
            value: isActive ? 'Active'.tr : 'Inactive'.tr,
            underline: Container(),
            padding: const EdgeInsets.only(left: 12),
            borderRadius: borderRadius,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (String? newValue) {
              if (newValue != null && onChanged != null) {
                onChanged!(newValue == 'Active'.tr);
              }
            },
            items: <String>['Active'.tr, 'Inactive'.tr]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: value == "Active".tr
                      ? activeTextStyle
                      : inactiveTextStyle,
                ),
              );
            }).toList(),
          ),
        ),
      );
    } else {
      return Text(
        isActive ? 'Active'.tr : 'Inactive'.tr,
        style: isActive ? activeTextStyle : inactiveTextStyle,
      );
      // Container(
      //   padding: const EdgeInsets.only(left: 6, right: 6, top: 12, bottom: 12),
      //   decoration: BoxDecoration(
      //     borderRadius: borderRadius,
      //     border: Border.all(color: Colors.grey),
      //   ),
      //   child: Text(
      //     isActive ? 'Active' : 'Inactive',
      //     style: isActive ? activeTextStyle : inactiveTextStyle,
      //   ),
      // );
    }
  }
}
