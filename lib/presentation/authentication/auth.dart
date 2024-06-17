import 'package:mindsight_admin_page/app_export.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.background,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: appTheme.white, borderRadius: BorderRadius.circular(32)),
          constraints: const BoxConstraints(maxWidth: 417, maxHeight: 438),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "로그인",
                style: CustomTextStyles.headlineLargeBlack,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomText(
                text: "Mindsight 관리자페이지",
                color: appTheme.grayScale6,
              ),
              const SizedBox(
                height: 32,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "이메일 주소",
                  labelStyle: CustomTextStyles.bodyMediumGray,
                  // floatingLabelStyle: TextStyle(color: appTheme.black),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  // hintText: "abc@domain.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: appTheme.grayScale3,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: appTheme.grayScale3,
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: appTheme.grayScale3,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: appTheme.grayScale3,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: appTheme.red,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: appTheme.red,
                      width: 2,
                    ),
                  ),
                  errorStyle: TextStyle(
                      color: appTheme.red,
                      fontSize: 12.fSize,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon: CustomImageView(
                    onTap: () {},
                    margin: const EdgeInsets.only(
                        right: 16, left: 12, top: 16, bottom: 16),
                    imagePath: IconConstant.visibilityFalse,
                  ),
                  // floatingLabelStyle: TextStyle(color: appTheme.black),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: "비밀번호",
                  labelStyle: CustomTextStyles.bodyMediumGray,
                  // hintText: "123",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: appTheme.grayScale3,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: appTheme.grayScale3,
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: appTheme.grayScale3,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: appTheme.grayScale3,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: appTheme.red,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: appTheme.red,
                      width: 2,
                    ),
                  ),
                  errorStyle: TextStyle(
                      color: appTheme.red,
                      fontSize: 12.fSize,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              CustomElevatedButton(
                height: 56,
                text: "Continue".tr,
                onPressed: () {
                  Get.offAllNamed(rootRoute);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "로그인에 문제가 있다면\nleochoi@nodame.com으로 문의하세요.",
                style: CustomTextStyles.bodyLargeGray,
                textAlign: TextAlign.center,
              ),
              // RichText(
              //     text: TextSpan(children: [
              //   const TextSpan(text: "Do not have admin credentials? "),
              //   TextSpan(
              //       text: "Request Credentials! ",
              //       style: TextStyle(color: appTheme.primary))
              // ]))
            ],
          ),
        ),
      ),
    );
  }
}



// // Obx(
              // //   () => 
              //   CustomTextFormField(
              //     // controller: controller.emailController,
              //     hintText: "Business email".tr,
              //     textInputType: TextInputType.emailAddress,
              //     // suffix:
              //     //     InkWell(
              //     //         onTap: () {
              //     //           // controller.emailController.clear();
              //     //         },
              //     //         child: Container(
              //     //           margin:
              //     //               EdgeInsets.fromLTRB(30.h, 16.v, 16.h, 16.v),
              //     //           child: CustomImageView(
              //     //             imagePath: IconConstant.close,
              //     //             color: appTheme.grayScale5,
              //     //             height: 24.adaptSize,
              //     //             width: 24.adaptSize,
              //     //           ),
              //     //         ),
              //     //       )
              //     //     ,
              //     // validator: (value) => controller.emailValidator(value),
              //     contentPadding: const EdgeInsets.symmetric(
              //       horizontal: 16,
              //       vertical: 16,
              //     ),
              //     borderDecoration: TextFormFieldStyleHelper.outlineGrayScale3,
              //     filled: true,
              //   ),
              // // ),
              // const SizedBox(height: 16),
              // // Obx(
              // //   () => 
              //   CustomTextFormField(
              //     // controller: controller.passwordController,
              //     hintText: "Password".tr,
              //     textInputAction: TextInputAction.done,
              //     textInputType: TextInputType.visiblePassword,
              //     suffix: InkWell(
              //       onTap: () {
              //         // controller.isObscured.value =
              //         // !controller.isObscured.value;
              //       },
              //       child: Container(
              //         // margin: EdgeInsets.fromLTRB(30.h, 16.v, 16.h, 16.v),
              //         child: CustomImageView(
              //           imagePath: IconConstant.visibilityFalse,
              //           // color: controller.isObscured.value
              //           //     ? appTheme.grayScale5
              //           //     : appTheme.black,
              //           height: 24,
              //           width: 24,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),