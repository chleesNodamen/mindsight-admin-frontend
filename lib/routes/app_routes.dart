import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_history_binding.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_history_view.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/admin_settings_binding.dart';
import 'package:mindsight_admin_page/presentation/authentication/auth__binding.dart';
import 'package:mindsight_admin_page/presentation/authentication/auth_view.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_manage_view.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/admin_settings_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_view.dart';
import 'package:mindsight_admin_page/presentation/dashboard/dashboard_binding.dart';
import 'package:mindsight_admin_page/presentation/dashboard/dashboard_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_manage_view.dart';
import 'package:mindsight_admin_page/presentation/terms_manage/terms_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/terms_manage/terms_manage_view.dart';



class AppRoutes{
  static const String rootRoute = "/";

  static const String auth = "/auth";
  static const String dashboard= "/dashboard";
  static const String memberManage = "/member_manage";
  static const String contentManage = "/content_manage";
  static const String activityManage = "/activity_manage";
  static const String termsManage = "/terms_manage";
  static const String adminSettings = "/admin_settings";
  static const String activityHistory = "/activity_history";

  static const String initialRoute = rootRoute;

  static List<GetPage> pages = [
     GetPage(
      name: rootRoute,
      page: () {
        return SiteLayout();
      },
    ),
    GetPage(
      name: auth,
      page: () => const AuthenticationView(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: dashboard,
      page: () => const DashboardView(),
      bindings: [DashboardBinding()],
    ),
    GetPage(
      name: memberManage,
      page: () => const MemberManageView(),
      bindings: [MemberManageBinding()],
    ),
    GetPage(
      name: contentManage,
      page: () => const ContentManageView(),
      bindings: [ContentManageBinding()],
    ),
    GetPage(
      name: activityManage,
      page: () => const ActivityManageView(),
      bindings: [ActivityManageBinding()],
    ),
    GetPage(
      name: activityHistory,
      page: () => const ActivityHistoryView(),
      bindings: [ActivityHistoryBinding()],
    ),
    GetPage(
      name: termsManage,
      page: () => const TermsManageView(),
      bindings: [TermsManageBinding()],
    ),
    GetPage(
      name: adminSettings,
      page: () => const AdminSettingsView(),
      bindings: [AdminSettingsBinding()],
    ),
  ];
}

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
  
}
const rootRoute = "/";
const dashboardPageRoute = "/dashboard";
const dashboardPageDisplayName = "대시보드";

const memberManagePageRoute = "/member_manage";
const memberManagePageDisplayName = "회원 관리";

const contentManagePageDisplayName = "콘텐츠 관리";
const contentManagePageRoute = "/content_manage";

const activityManagePageDisplayName = "활동 기록 관리";
const activityManagePageRoute = "/activity_manage";

const activityHistoryPageDisplayName = "활동 기록 상세";
const activityHistoryPageRoute = "/activity_history";

const termsManagePageDisplayName = "약관 관리";
const termsManagePageRoute = "/terms_manage";

const adminSettingsPageDisplayName = "관리자 설정";
const adminSettingsPageRoute = "/admin_settings";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";


List<MenuItem> sideMenuItemRoutes = [
  MenuItem(dashboardPageDisplayName, dashboardPageRoute),
  MenuItem(memberManagePageDisplayName, memberManagePageRoute),
  MenuItem(contentManagePageDisplayName, contentManagePageRoute),
  MenuItem(activityManagePageDisplayName, activityManagePageRoute),
  MenuItem(adminSettingsPageDisplayName, adminSettingsPageRoute),
  MenuItem(termsManagePageDisplayName, termsManagePageRoute),
  // MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
