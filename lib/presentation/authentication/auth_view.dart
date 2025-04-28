import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/authentication/auth_controller.dart';

class AuthenticationView extends GetWidget<AuthenticationController> {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: appTheme.background,
          body: PageLoadingIndicator(
            isLoading: controller.isLoading.value,
            child: controller.isLoginMode.value
                ? _buildAuthBody(isLogin: true)
                : _buildAuthBody(isLogin: false),
          ),
        ));
  }

  Widget _buildAuthBody({required bool isLogin}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAuthCard(isLogin: isLogin),
          const SizedBox(height: 25),
          if (isLogin) _buildVersionInfo(),
        ],
      ),
    );
  }

  Widget _buildAuthCard({required bool isLogin}) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: BorderRadiusStyle.roundedBorder32,
      ),
      constraints: const BoxConstraints(maxWidth: 420),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text(
            isLogin ? "Login".tr : "Sign up".tr,
            style: CustomTextStyles.headlineLargeBlack,
          ),
          const SizedBox(height: 8),
          Text(
            isLogin
                ? "Mindsight admin page".tr
                : "Please choose a sign-up method".tr,
            style: CustomTextStyles.bodySmallGray,
          ),
          const SizedBox(height: 50),
          if (isLogin) ...[
            _buildEmailInput(),
            const SizedBox(height: 16),
            _buildPasswordInput(),
            const SizedBox(height: 20),
            _buildLoginButton(),
            const SizedBox(height: 20),
            _buildDivider(),
            const SizedBox(height: 20),
            _buildGoogleButton(isLogin: true),
            const SizedBox(height: 20),
            _buildSwitchAuthText(isLogin: true),
            const SizedBox(height: 20),
            _buildForgotPassword(),
          ] else ...[
            _buildEmailSignupButton(),
            const SizedBox(height: 20),
            _buildGoogleButton(isLogin: false),
            const SizedBox(height: 20),
            _buildSwitchAuthText(isLogin: false),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return CustomTextFormField(
      controller: controller.emailController,
      hintText: "Email address".tr,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofocus: false,
      filled: true,
      width: double.infinity,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text'.tr;
        }
        return null;
      },
    );
  }

  Widget _buildPasswordInput() {
    return CustomTextFormField(
      controller: controller.passwordController,
      hintText: "Password".tr,
      obscureText: controller.isObscured.value,
      textInputAction: TextInputAction.done,
      autofocus: false,
      filled: true,
      width: double.infinity,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      suffix: InkWell(
        onTap: () => controller.isObscured.toggle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
          child: CustomImageView(
            imagePath: controller.isObscured.value
                ? IconConstant.visibilityFalse
                : IconConstant.visibilityTrue,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return CustomElevatedButton(
      text: "Login".tr,
      onPressed: controller.onContinue,
      width: double.infinity,
      height: 56,
      buttonStyle: CustomButtonStyles.fillPrimary.copyWith(
        elevation: MaterialStateProperty.all(0),
      ),
    );
  }

  Widget _buildGoogleButton({required bool isLogin}) {
    return CustomElevatedButton(
      text: isLogin ? "Login with Google".tr : "Sign up with Google".tr,
      onPressed: isLogin
          ? controller.onSigninWithGoogle
          : controller.onSignupWithGoogle,
      width: double.infinity,
      height: 56,
      leftIcon: CustomImageView(imagePath: IconConstant.google),
      buttonStyle: CustomButtonStyles.outlineGray.copyWith(
        elevation: MaterialStateProperty.all(0),
      ),
      buttonTextStyle: CustomTextStyles.bodyMediumBlack,
    );
  }

  Widget _buildEmailSignupButton() {
    return CustomElevatedButton(
      text: "Sign up with email address".tr,
      onPressed: () => Get.offAllNamed(AppRoutes.verifyEmail0),
      width: double.infinity,
      height: 56,
      leftIcon: CustomImageView(imagePath: IconConstant.send),
      buttonStyle: CustomButtonStyles.outlineGray.copyWith(
        elevation: MaterialStateProperty.all(0),
      ),
      buttonTextStyle: CustomTextStyles.bodyMediumBlack,
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: appTheme.grayScale3)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text("or".tr, style: CustomTextStyles.bodySmallGray),
        ),
        Expanded(child: Divider(color: appTheme.grayScale3)),
      ],
    );
  }

  Widget _buildSwitchAuthText({required bool isLogin}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin
              ? "Don’t have an account yet?".tr
              : "Already have an account?".tr,
          style: CustomTextStyles.bodySmallBlack,
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () => controller.isLoginMode.value = !isLogin,
          child: Text(
            isLogin ? "Sign up".tr : "Sign in".tr,
            style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return InkWell(
      onTap: () => Get.offAllNamed(AppRoutes.changePassword0),
      child: Text(
        "Forgot password?".tr,
        style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Text(
      "${"If you have issues logging in,\ncontact mindsight@nodame.com.".tr}\n\nVERSION.${AppConstant.version}",
      style: CustomTextStyles.labelLargeGray,
      textAlign: TextAlign.center,
    );
  }
}
