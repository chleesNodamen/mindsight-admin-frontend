// import 'package:mindsight_admin_page/app_export.dart';
// import 'package:mindsight_admin_page/presentation/settlement_manage/settlement_manage_controller.dart';

// class CustomMonthPickerDialog extends StatefulWidget {
//   const CustomMonthPickerDialog({super.key});

//   @override
//   State<CustomMonthPickerDialog> createState() =>
//       _CustomMonthPickerDialogState();
// }

// class _CustomMonthPickerDialogState extends State<CustomMonthPickerDialog> {
//   int selectedYear = DateTime.now().year;
//   int selectedMonth = DateTime.now().month;

//   @override
//   Widget build(BuildContext context) {
//     // Year 리스트 생성 (예: Current Year부터 100년 전까지)
//     List<int> years =
//         List<int>.generate(100, (index) => DateTime.now().year - index);

//     // 월 리스트 생성
//     List<int> months = List<int>.generate(12, (index) => index + 1);

//     return AlertDialog(
//       title: Text("Select month".tr),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Year 선택 Dropdown
//           DropdownButtonFormField<int>(
//             value: selectedYear,
//             decoration: InputDecoration(
//               labelText: "Year".tr,
//               // border: OutlineInputBorder(),
//             ),
//             items: years
//                 .map((year) => DropdownMenuItem(
//                       value: year,
//                       child: Text(year.toString()),
//                     ))
//                 .toList(),
//             onChanged: (value) {
//               setState(() {
//                 selectedYear = value!;
//               });
//             },
//           ),
//           const SizedBox(height: 20),
//           // Select month Dropdown
//           DropdownButtonFormField<int>(
//             value: selectedMonth,
//             decoration: InputDecoration(
//               labelText: "Month".tr,
//               // border: OutlineInputBorder(),
//             ),
//             items: months
//                 .map((month) => DropdownMenuItem(
//                       value: month,
//                       child: Text(month.toString()),
//                     ))
//                 .toList(),
//             onChanged: (value) {
//               setState(() {
//                 selectedMonth = value!;
//               });
//             },
//           ),
//         ],
//       ),
//       actions: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomElevatedButton(
//                 text: "Confirm".tr,
//                 buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
//                 buttonStyle: CustomButtonStyles.fillPrimary,
//                 margin: const EdgeInsets.only(bottom: 15),
//                 // width: 94,
//                 height: 44,
//                 onPressed: () async {
//                   await SettlementManageController.to.changeMonth(
//                     MonthType.selectedMonth,
//                     year: selectedYear,
//                     monthNumber: selectedMonth,
//                   );
//                   Navigator.of(context).pop();
//                 }),
//             CustomElevatedButton(
//                 text: "Cancel".tr,
//                 buttonTextStyle: CustomTextStyles.bodyMediumSkyBlueBold,
//                 buttonStyle: CustomButtonStyles.fillPrimaryTransparent,
//                 margin: const EdgeInsets.only(left: 10, bottom: 15),
//                 // width: 94,
//                 height: 44,
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 }),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:mindsight_admin_page/app_export.dart';

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
    // Year 리스트 생성 (예: Current Year부터 100년 전까지)
    List<int> years =
        List<int>.generate(100, (index) => DateTime.now().year - index);

    // 월 리스트 생성
    List<int> months = List<int>.generate(12, (index) => index + 1);

    return AlertDialog(
      title: Text("Select month".tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Year 선택 Dropdown
          DropdownButtonFormField<int>(
            value: selectedYear,
            decoration: InputDecoration(
              labelText: "Year".tr,
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
          // Select month Dropdown
          DropdownButtonFormField<int>(
            value: selectedMonth,
            decoration: InputDecoration(
              labelText: "Month".tr,
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
                text: "Confirm".tr,
                buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
                buttonStyle: CustomButtonStyles.fillPrimary,
                margin: const EdgeInsets.only(bottom: 15),
                // width: 94,
                height: 44,
                onPressed: () {
                  Navigator.of(context).pop({
                    'year': selectedYear,
                    'monthNumber': selectedMonth,
                  });
                }),
            CustomElevatedButton(
                text: "Cancel".tr,
                buttonTextStyle: CustomTextStyles.bodyMediumSkyBlueBold,
                buttonStyle: CustomButtonStyles.fillPrimaryTransparent,
                margin: const EdgeInsets.only(left: 10, bottom: 15),
                // width: 94,
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
