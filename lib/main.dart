import 'package:mindsight_admin_page/initial_bindings/initial_bindings.dart';
import 'app_export.dart';

void main() {
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
        title: 'Dashboard',
        theme: theme,
        initialBinding: InitialBindings(),
      );
    });
  }
}
