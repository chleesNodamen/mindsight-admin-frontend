// import 'package:mindsight_admin_page/app_export.dart';
// import 'package:mindsight_admin_page/enum/contry.dart';
// import 'package:mindsight_admin_page/function/show_company_search_dialog.dart';
// import 'package:mindsight_admin_page/presentation/master_manage/master_register/master_register_controller.dart';

// class MasterRegisterView extends GetWidget<MasterRegisterController> {
//   const MasterRegisterView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//     return Obx(
//       () => Scaffold(
//         extendBodyBehindAppBar: true,
//         body: PageLoadingIndicator(
//           isLoading: controller.isLoading.value,
//           child: controller.isInited.value
//               ? ResponsiveWidget(
//                   largeScreen: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SideMenu(),
//                       Expanded(
//                         child: ListView(
//                           children: [
//                             Container(
//                               margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
//                               child: Form(
//                                 key: formKey,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     _buildTitle(),
//                                     const SizedBox(height: 32),
//                                     _buildAccountInfo(),
//                                     const SizedBox(height: 32),
//                                     _buildSaveNCancel(formKey)
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : const SizedBox.shrink(),
//         ),
//       ),
//     );
//   }

//   Widget _buildAccountInfo() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         BuildInput(
//           label: "ID".tr,
//           essential: true,
//           textController: controller.emailController,
//           keyboardType: TextInputType.emailAddress,
//           enabled: false,
//           textStyle: CustomTextStyles.bodyMediumGray,
//         ),
//         const SizedBox(height: 24),
//         Row(
//           children: [
//             _buildLanguage("Primary Language".tr, true,
//                 controller.selectedPrimaryLanguage),
//             const SizedBox(width: 24),
//             BuildInput(
//                 label: "Primary Nickname".tr,
//                 essential: true,
//                 toolTip: "Please enter your display name".tr,
//                 textController: controller.primaryNicknameController),
//           ],
//         ),
//         const SizedBox(height: 24),
//         Row(
//           children: [
//             _buildLanguage("Secondary Language".tr, false,
//                 controller.selectedPrimaryLanguage),
//             const SizedBox(width: 24),
//             BuildInput(
//                 label: "Secondary Nickname".tr,
//                 toolTip: "Please enter your display name".tr,
//                 essential: false,
//                 textController: controller.secodaryNicknameController),
//           ],
//         ),
//         const SizedBox(height: 24),
//         Row(
//           children: [
//             BuildInput(
//                 label: "Password".tr,
//                 essential: true,
//                 textController: controller.passwordController),
//             const SizedBox(width: 24),
//             BuildInput(
//                 label: "Password Confirm".tr,
//                 essential: true,
//                 textController: controller.passwordCofirmController),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildLanguage(
//       String text, bool essential, Rx<ContentLanguage?> selectedLanguage) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         RichText(
//             text: TextSpan(children: [
//           TextSpan(
//               text: "$text ",
//               style: CustomTextStyles.labelLargeBlack
//                   .copyWith(fontWeight: FontWeight.w600)),
//           TextSpan(
//               text: essential ? "*" : "", style: TextStyle(color: appTheme.red))
//         ])),
//         const SizedBox(height: 8),
//         Container(
//           width: 353,
//           decoration: BoxDecoration(
//             border: Border.all(
//               width: 1,
//               color: appTheme.grayScale3,
//             ),
//             color: appTheme.white,
//             borderRadius: BorderRadiusStyle.roundedBorder12,
//           ),
//           child: DropdownButton<ContentLanguage>(
//             hint: Text("Select Option".tr,
//                 style: CustomTextStyles.bodyMediumGray),
//             isExpanded: true,
//             value: selectedLanguage.value,
//             underline: Container(),
//             padding:
//                 const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
//             borderRadius: BorderRadiusStyle.roundedBorder12,
//             // icon: const Icon(Icons.),
//             elevation: 16,
//             onChanged: (ContentLanguage? newValue) {
//               selectedLanguage.value = newValue;
//             },
//             items: controller.languageLabels
//                 .map<DropdownMenuItem<ContentLanguage>>(
//                     (ContentLanguage value) {
//               return DropdownMenuItem<ContentLanguage>(
//                 value: value,
//                 child: Text(
//                   value.displayName.tr,
//                   style: CustomTextStyles.bodyMediumBlack,
//                 ),
//               );
//             }).toList(),
//           ),
//         )
//       ],
//     );
//   }

//   Row _buildSaveNCancel(GlobalKey<FormState> formKey) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         CustomElevatedButton(
//           text: 'Sign-up complete'.tr,
//           buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
//           buttonStyle: CustomButtonStyles.fillPrimary,
//           // width: 90,
//           height: 44,
//           onPressed: () {
//             if (formKey.currentState!.validate()) {
//               controller.onSignupComplete();
//             }
//           },
//         ),
//         CustomElevatedButton(
//           text: 'Cancel'.tr,
//           buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
//           buttonStyle: CustomButtonStyles.fillRedTransparent,
//           margin: const EdgeInsets.only(left: 16),
//           // width: 90,
//           height: 44,
//           onPressed: () => Account.isLogined
//               ? Get.offAllNamed(AppRoutes.masterManage)
//               : Get.offAllNamed(AppRoutes.auth),
//         ),
//       ],
//     );
//   }

//   TobBarSearch _buildTitle() {
//     return TobBarSearch(
//       name: "Master New registration".tr,
//       searchShow: false,
//       viewCount: false,
//     );
//   }
// }
