import 'package:flutter/material.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/settlement_manage_controller.dart';
import 'package:mindsight_admin_page/theme/custom_button_style.dart';
import 'package:mindsight_admin_page/theme/custom_text_style.dart';
import 'package:mindsight_admin_page/widgets/custom_elevated_button.dart';

class CustomMonthPickerDialog extends StatefulWidget {
  const CustomMonthPickerDialog({super.key});

  @override
  State<CustomMonthPickerDialog> createState() =>
      _CustomMonthPickerDialogState();
}

class _CustomMonthPickerDialogState extends State<CustomMonthPickerDialog> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    // 연도 리스트 생성 (예: 현재 연도부터 100년 전까지)
    List<int> years =
        List<int>.generate(100, (index) => DateTime.now().year - index);

    // 월 리스트 생성
    List<int> months = List<int>.generate(12, (index) => index + 1);

    return AlertDialog(
      title: const Text("월 선택"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 연도 선택 Dropdown
          DropdownButtonFormField<int>(
            value: selectedYear,
            decoration: const InputDecoration(
              labelText: "연도",
              // border: OutlineInputBorder(),
            ),
            items: years
                .map((year) => DropdownMenuItem(
                      value: year,
                      child: Text(year.toString()),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedYear = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          // 월 선택 Dropdown
          DropdownButtonFormField<int>(
            value: selectedMonth,
            decoration: const InputDecoration(
              labelText: "월",
              // border: OutlineInputBorder(),
            ),
            items: months
                .map((month) => DropdownMenuItem(
                      value: month,
                      child: Text(month.toString()),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedMonth = value!;
              });
            },
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
                text: "확인",
                buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
                buttonStyle: CustomButtonStyles.fillPrimary,
                margin: const EdgeInsets.only(bottom: 15),
                width: 94,
                height: 44,
                onPressed: () async {
                  await SettlementManageController.to.changeMonth(
                    MonthType.selectedMonth,
                    year: selectedYear,
                    monthNumber: selectedMonth,
                  );
                  Navigator.of(context).pop();
                }),
            CustomElevatedButton(
                text: "취소",
                buttonTextStyle: CustomTextStyles.bodyMediumSkyBlueBold,
                buttonStyle: CustomButtonStyles.fillPrimaryTransparent,
                margin: const EdgeInsets.only(left: 10, bottom: 15),
                width: 94,
                height: 44,
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ],
    );
  }
}
