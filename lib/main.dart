import 'dart:async';
import 'app_export.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

Future<void> main() async {
  Logger.info("앱 시작: ${html.window.location.href}");

  WidgetsFlutterBinding.ensureInitialized(); // 비동기 작업을 위해 필요

  Get.put(PrefUtils());
  Get.put(CustomHttpClient());
  Get.put(SideMenuController());

  // PrefUtils 초기화 되는 시간으로 500 밀리 딜레이를 주었음
  await Future.delayed(const Duration(milliseconds: 500));
  await ReloadHandler.autoSignin();

  // if (PrefUtils.to.getLocaleLanguageCode().isNotEmpty) {
  //   Get.updateLocale(Locale(PrefUtils.to.getLocaleLanguageCode()));
  // } else {
  //   Logger.info("언어값 없어서 디바이스 기본값으로 셋팅: ${Get.deviceLocale!.languageCode}");
  //   PrefUtils.to.setLocaleLanguageCode(Get.deviceLocale!.languageCode);
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        initialRoute: AppRoutes.auth,
        unknownRoute: GetPage(
            name: '/not-found',
            page: () => const PageNotFound(),
            transition: Transition.noTransition),
        getPages: AppRoutes.pages,
        defaultTransition: Transition.noTransition,
        debugShowCheckedModeBanner: false,
        title: 'Mindsight 관리자',
        theme: theme,
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        // initialBinding: InitialBindings(),
      );
    });
  }
}
