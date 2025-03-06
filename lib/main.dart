import 'dart:async';
import 'package:mindsight_admin_page/initial_bindings/initial_bindings.dart';
import 'package:mindsight_admin_page/localization/app_localization.dart';
import 'app_export.dart';
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

  initLocaleLanguage();

  runApp(const MyApp());
}

void initLocaleLanguage() {
  ContentLanguage lang = PrefUtils.to.getLocaleLanguage();
  Logger.log("언어설정:$lang");
  Get.updateLocale(Locale(lang.languageCode));
  PrefUtils.to.setLocaleLanguage(lang);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        initialRoute: AppRoutes.initialRoute,
        unknownRoute: GetPage(
            name: '/not-found',
            page: () => const PageNotFound(),
            transition: Transition.noTransition),
        getPages: AppRoutes.pages,
        defaultTransition: Transition.noTransition,
        debugShowCheckedModeBanner: false,
        title: 'Mindsight 관리자',
        theme: theme,
        // locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        translations: AppLocalization(),
        initialBinding: InitialBindings(),
      );
    });
  }
}
