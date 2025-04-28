import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:mindsight_admin_page/firebase_options.dart';
import 'package:mindsight_admin_page/initial_bindings/initial_bindings.dart';
import 'package:mindsight_admin_page/localization/app_localization.dart';
import 'app_export.dart';
// ignore: deprecated_member_use
import 'dart:html' as html;

Future<void> main() async {
  Logger.info("앱 시작: ${html.window.location.href}");

  WidgetsFlutterBinding.ensureInitialized(); // 비동기 작업을 위해 필요

  if (kReleaseMode) {
    // 배포 환경에서는 firebase.initializeApp() 호출 생략
    Logger.info("Release Mode: firebase.initializeApp 생략");
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  Get.put(PrefUtils());
  Get.put(CustomHttpClient());
  Get.put(SideMenuController());

  while (true) {
    await Future.delayed(const Duration(milliseconds: 100));
    if (PrefUtils.to.isInited()) {
      break;
    }
  }

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
