import 'package:mindsight_admin_page/initial_bindings/initial_bindings.dart';
import 'app_export.dart';
import 'package:mindsight_admin_page/controllers/menu_controller.dart'
    as menu_controller;

void main() {
  Get.put(menu_controller.MenuController());
  Get.put(NavigationController());
  // Get.lazyPut(() => ContentManageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        initialRoute: AppRoutes.dashboard,
        unknownRoute: GetPage(
            name: '/not-found',
            page: () => const PageNotFound(),
            transition: Transition.fadeIn),
        getPages: AppRoutes.pages,
        debugShowCheckedModeBanner: false,
        title: 'Dashboard',
        theme: theme,
        initialBinding: InitialBindings(),
      );
    });
  }
}
