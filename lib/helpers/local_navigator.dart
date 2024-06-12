import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/controllers.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: dashboardPageRoute,
    );
