import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_history_binding.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_history_view.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_manage_controller.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/admin_settings_binding.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/admin_settings_controller.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_details/sub_admin_details_bindin.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_details/sub_admin_details_view.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_edit/sub_admin_edit_binding.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_edit/sub_admin_edit_view.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_register/sub_admin_register_binding.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_register/sub_admin_register_view.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_settings_binding.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_settings_view.dart';
import 'package:mindsight_admin_page/presentation/authentication/auth_binding.dart';
import 'package:mindsight_admin_page/presentation/authentication/auth_view.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_manage_view.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/admin_settings_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage/challenge_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage/challenge_manage_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage_details/challenge_details_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage_details/challenge_details_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage_edit/challenge_edit_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage_edit/challenge_edit_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_controller.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_details/content_details_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_details/content_details_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_edit/content_edit_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_edit/content_edit_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_register/content_register_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_register/content_register_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_details/practice_details_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_details/practice_details_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_edit/practice_edit_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_edit/practice_edit_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_manage/practice_plan_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_manage/practice_plan_manage_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_register/practice_register_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_register/practice_register_view.dart';
import 'package:mindsight_admin_page/presentation/dashboard/dashboard_binding.dart';
import 'package:mindsight_admin_page/presentation/dashboard/dashboard_controller.dart';
import 'package:mindsight_admin_page/presentation/dashboard/dashboard_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/inactive_member_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/member_manage/inactive_member_manage_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_details_binding.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_details_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_edit_binding.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_edit_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_manage_controller.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_manage_view.dart';

class AppRoutes {
  static const String rootRoute = "/";

  static const String auth = "/auth";
  static const String dashboard = "/dashboard";
  static const String memberManage = "/member_manage";
  static const String inactiveMemberManage = "/inactive_member_manage";
  static const String memberDetails = "/member_details";
  static const String memberEdit = "/member_edit";
  static const String contentManage = "/content_manage";
  static const String contentDetails = "/content_details";
  static const String contentManageList = "/content_manage_list";
  static const String contentRegister = "/content_register";
  static const String contentEdit = "/content_edit";
  static const String contentPracticePlanManage =
      "/content_practice_plan_manage";
  static const String practiceRegister = "/practice_register";
  static const String practiceEdit = "/practice_edit";
  static const String practiceDetails = "/practice_details";
  static const String contentChallengeManage = "/content_challenge_manage";
  static const String challengeDetails = "/challenge_details";
  static const String challengeEdit = "/challenge_edit";
  static const String activityManage = "/activity_manage";
  static const String termsManage = "/terms_manage";
  static const String adminSettings = "/admin_settings";
  static const String subAdminSettings = '/sub_admin_settings';
  static const String subAdminRegister = '/sub_admin_register';
  static const String subAdminDetails = '/sub_admin_details';
  static const String subAdminEdit = '/sub_admin_edit';
  static const String activityHistory = "/activity_history";

  static const String initialRoute = activityHistory;

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
      name: inactiveMemberManage,
      page: () => const InactiveMemberManageView(),
      bindings: [InactiveMemberManageBinding()],
    ),
    GetPage(
      name: memberDetails,
      page: () => const MemberDetailsView(),
      bindings: [MemberDetailsBinding()],
    ),
    GetPage(
      name: memberEdit,
      page: () => const MemberEditView(),
      bindings: [MemberEditBinding()],
    ),
    GetPage(
      name: contentManage,
      page: () => const ContentManageView(),
      bindings: [ContentManageBinding()],
    ),
    GetPage(
      name: contentRegister,
      page: () => const ContentRegisterView(),
      bindings: [ContentRegisterBinding()],
    ),
    GetPage(
      name: contentEdit,
      page: () => const ContentEditView(),
      bindings: [ContentEditBinding()],
    ),
    GetPage(
      name: contentDetails,
      page: () => const ContentDetailsView(),
      bindings: [ContentDetailsBinding()],
    ),
    GetPage(
        name: practiceRegister,
        page: () => const PracticeRegisterView(),
        bindings: [PracticeRegisterBinding()]),
    GetPage(
        name: practiceDetails,
        page: () => const PracticeDetailsView(),
        bindings: [PracticeDetailsBinding()]),
    GetPage(
        name: practiceEdit,
        page: () => const PracticeEditView(),
        bindings: [PracticeEditBinding()]),
    GetPage(
        name: contentChallengeManage,
        page: () => const ChallengeManageView(),
        bindings: [ChallengeManageBinding()]),
    GetPage(
      name: contentDetails,
      page: () => const ContentDetailsView(),
      bindings: [ContentDetailsBinding()],
    ),
    GetPage(
      name: contentPracticePlanManage,
      page: () => const PracticePlanManageView(),
      bindings: [PracticePlanManageBinding()],
    ),
    GetPage(
      name: contentChallengeManage,
      page: () => const ChallengeManageView(),
      bindings: [ChallengeManageBinding()],
    ),
    GetPage(
      name: challengeDetails,
      page: () => const ChallengeDetailsView(),
      bindings: [ChallengeDetailsBinding()],
    ),
    GetPage(
      name: challengeEdit,
      page: () => const ChallengeEditView(),
      bindings: [ChallengeEditBinding()],
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
      name: adminSettings,
      page: () => const AdminSettingsView(),
      bindings: [AdminSettingsBinding()],
    ),
    GetPage(
      name: subAdminSettings,
      page: () => const SubAdminSettingsView(),
      bindings: [SubAdminSettingsBinding()],
    ),
    GetPage(
      name: subAdminRegister,
      page: () => const SubAdminRegisterView(),
      bindings: [SubAdminRegisterBinding()],
    ),
    GetPage(
      name: subAdminEdit,
      page: () => const SubAdminEditView(),
      bindings: [SubAdminEditBinding()],
    ),
    GetPage(
      name: subAdminDetails,
      page: () => const SubAdminDetailsView(),
      bindings: [SubAdminDetailsBinding()],
    ),
  ];
}

class MenuItem {
  final String name;
  final String route;
  final Function inited;

  MenuItem(this.name, this.route, this.inited);
}

const rootRoute = "/";
const dashboardPageRoute = "/dashboard";
const dashboardPageDisplayName = "대시보드";

const memberManagePageRoute = "/member_manage";
const memberManagePageSubMenuDisplayName = "회원 목록";
const memberManagePageDisplayName = "회원 관리";

const memberDetailsPageRoute = "/member_details";
const memberDetailsPageDisplayName = "회원 상세";

const memberEditPageRoute = "/member_edit";
const memberEditPageDisplayName = "사전 정보 수정";

const inactiveMemberManagePageRoute = "/inactive_member_manage";
const inactiveMemberManagePageDisplayName = "비활성 회원 관리";

const contentManagePageDisplayName = "콘텐츠 관리";
const contentManagePageRoute = "/content_manage";
const contentManageContentDisplayName = "콘텐츠 목록";
const contentPracticePlanDisplayName = "Practice plan 관리";
const contentChallengeDisplayName = "Challenge 관리";

const activityManagePageDisplayName = "활동 기록 관리";
const activityManagePageRoute = "/activity_manage";

const activityHistoryPageDisplayName = "활동 기록 상세";
const activityHistoryPageRoute = "/activity_history";

const adminSettingsPageDisplayName = "관리자 설정";
const myAccountManageDisplayName = "내 계정 관리";
const subAdminSettingsDisplayName = "서브 관리자 관리";
const adminSettingsPageRoute = "/admin_settings";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(dashboardPageDisplayName, AppRoutes.dashboard, () {
    if (Get.isRegistered<DashboardController>()) {
      Get.find<DashboardController>().loadData();
    }
  }),
  MenuItem(memberManagePageDisplayName, AppRoutes.memberManage, () {
    if (Get.isRegistered<MemberManageController>()) {
      Get.find<MemberManageController>().loadData();
    }
  }),
  MenuItem(contentManagePageDisplayName, AppRoutes.contentManage, () {
    if (Get.isRegistered<ContentManageController>()) {
      Get.find<ContentManageController>().loadData();
    }
  }),
  MenuItem(activityManagePageDisplayName, AppRoutes.activityManage, () {
    if (Get.isRegistered<ActivityManageController>()) {
      Get.find<ActivityManageController>().loadData();
    }
  }),
  MenuItem(adminSettingsPageDisplayName, AppRoutes.adminSettings, () {
    if (Get.isRegistered<AdminSettingsController>()) {
      Get.find<AdminSettingsController>().loadData();
    }
  }),
  // MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
