import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/authentication/auth_controller.dart';

class AuthenticationView extends GetWidget<AuthenticationController> {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: appTheme.background,
          body: controller.isLoginMode.value ? _buildLogin() : _buildSignup(),
        ));
  }

  Center _buildLogin() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: appTheme.white,
                borderRadius: BorderRadiusStyle.roundedBorder32),
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Login".tr,
                  style: CustomTextStyles.headlineLargeBlack,
                ),
                const SizedBox(height: 8),
                CustomText(
                  text: "Mindsight admin page".tr,
                  color: appTheme.grayScale6,
                ),
                const SizedBox(height: 50),
                CustomTextFormField(
                  controller: controller.emailController,
                  width: double.infinity,
                  hintText: "Email address".tr,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 16), // 56px 맞춤
                  suffix: null, // 이메일은 별도 suffix 없음
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  controller: controller.passwordController,
                  width: double.infinity,
                  hintText: "Password".tr,
                  obscureText: controller.isObscured.value,
                  textInputAction: TextInputAction.done,
                  autofocus: false,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 16), // 56px 맞춤
                  suffix: InkWell(
                    onTap: () {
                      controller.isObscured.value =
                          !controller.isObscured.value;
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                      child: CustomImageView(
                        imagePath: controller.isObscured.value
                            ? IconConstant.visibilityFalse
                            : IconConstant.visibilityTrue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomElevatedButton(
                  height: 56,
                  text: "Login".tr,
                  width: double.infinity,
                  onPressed: () {
                    controller.onContinue();
                  },
                  buttonStyle: CustomButtonStyles.fillPrimary
                      .copyWith(elevation: MaterialStateProperty.all(0)),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(child: Divider(color: appTheme.grayScale3)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text("or".tr, style: CustomTextStyles.bodySmallGray),
                  ),
                  Expanded(child: Divider(color: appTheme.grayScale3)),
                ]),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  width: double.infinity,
                  height: 56,
                  leftIcon: CustomImageView(imagePath: IconConstant.google),
                  text: "Login with Google".tr,
                  // leftIcon: Image.asset(IconConstant.aabbcc, height: 20),
                  buttonStyle: CustomButtonStyles.outlineGray
                      .copyWith(elevation: MaterialStateProperty.all(0)),
                  buttonTextStyle: CustomTextStyles.bodyMediumBlack,
                  onPressed: controller.onGoogleLogin,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account yet?".tr,
                        style: CustomTextStyles.bodySmallBlack),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        controller.isLoginMode.value = false;
                      },
                      child: Text("Sign up".tr,
                          style: CustomTextStyles.bodyMediumSkyBlue
                              .copyWith(decoration: TextDecoration.underline)),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Get.offAllNamed(AppRoutes.changePassword0);
                  },
                  child: Text(
                    "Forgot password?".tr,
                    style: CustomTextStyles.bodyMediumSkyBlue
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            "${"If you have issues logging in,\ncontact mindsight@nodame.com.".tr} \n\nVERSION.${AppConstant.version}",
            style: CustomTextStyles.labelLargeGray,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Center _buildSignup() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: appTheme.white,
                borderRadius: BorderRadiusStyle.roundedBorder32),
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Sign up".tr,
                  style: CustomTextStyles.headlineLargeBlack,
                ),
                const SizedBox(height: 8),
                CustomText(
                  text: "Please choose a sign-up method".tr,
                  color: appTheme.grayScale6,
                ),
                const SizedBox(height: 50),
                CustomElevatedButton(
                  width: double.infinity,
                  height: 56,
                  leftIcon: CustomImageView(imagePath: IconConstant.send),
                  text: "Sign up with email address".tr,
                  buttonStyle: CustomButtonStyles.outlineGray
                      .copyWith(elevation: MaterialStateProperty.all(0)),
                  buttonTextStyle: CustomTextStyles.bodyMediumBlack,
                  onPressed: () => Get.offAllNamed(AppRoutes.verifyEmail0),
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  width: double.infinity,
                  height: 56,
                  leftIcon: CustomImageView(imagePath: IconConstant.google),
                  text: "Login with Google".tr,
                  // leftIcon: Image.asset(IconConstant.aabbcc, height: 20),
                  buttonStyle: CustomButtonStyles.outlineGray
                      .copyWith(elevation: MaterialStateProperty.all(0)),
                  buttonTextStyle: CustomTextStyles.bodyMediumBlack,
                  onPressed: controller.onGoogleLogin,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?".tr,
                        style: CustomTextStyles.bodySmallBlack),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        controller.isLoginMode.value = true;
                      },
                      child: Text("Sign in".tr,
                          style: CustomTextStyles.bodyMediumSkyBlue
                              .copyWith(decoration: TextDecoration.underline)),
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
