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
                    hintText: "abc@domain.com",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "비밀번호",
                    hintText: "123",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              const SizedBox(
                height: 32,
              ),
              InkWell(
                onTap: () {
                  Get.offAllNamed(rootRoute);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: appTheme.primary,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const CustomText(
                    text: "로그인",
                    color: Colors.white,
                  ),
                ),
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
