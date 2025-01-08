import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_history_binding.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_history_view.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/admin_settings_binding.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/etc_admin_settings_binding.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/etc_admin_settings_view.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_details/sub_admin_details_bindin.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_details/sub_admin_details_view.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_edit/sub_admin_edit_binding.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_edit/sub_admin_edit_view.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_register/sub_admin_register_binding.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_register/sub_admin_register_view.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_settings_binding.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_settings_view.dart';
import 'package:mindsight_admin_page/presentation/authentication/auth_binding.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_manage_view.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/admin_settings_view.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_details_binding.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_details_view.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_edit_binding.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_edit_view.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_manage_view.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_mass_register_binding.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_mass_register_view.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_register_binding.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_register_view.dart';
import 'package:mindsight_admin_page/presentation/company_manage/inactive_company_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/company_manage/inactive_company_manage_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage/challenge_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage/challenge_manage_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_details/challenge_details_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_details/challenge_details_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_edit/challenge_edit_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_edit/challenge_edit_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_register/challenge_register_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_register/challenge_register_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_details/content_details_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_details/content_details_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_edit/content_edit_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_edit/content_edit_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_register/content_register_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_register/content_register_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_details/practice_details_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_details/practice_details_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_edit/practice_edit_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_edit/practice_edit_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_manage/practice_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_manage/practice_manage_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_register/practice_register_binding.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_register/practice_register_view.dart';
import 'package:mindsight_admin_page/presentation/dashboard/dashboard_binding.dart';
import 'package:mindsight_admin_page/presentation/dashboard/dashboard_view.dart';
import 'package:mindsight_admin_page/presentation/master_manage/inactive_master_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/master_manage/inactive_master_manage_view.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_details_binding.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_details_view.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_edit_binding.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_edit_view.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_manage_view.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_mass_register_binding.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_mass_register_view.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_register_binding.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_register_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/inactive_member_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/member_manage/inactive_member_manage_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_details_binding.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_details_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_edit_binding.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_edit_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_manage_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_mass_register_binding.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_mass_register_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_register_binding.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_register_view.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/master_settlement_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/master_settlement_manage_view.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/revenue_share_manage_binding_nouse.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/revenue_share_manage_view_nouse.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/settlement_manage_binding.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/settlement_manage_view.dart';

class AppRoutes {
  // static const String rootRoute = "/";
  static const String auth = "/auth";
  static const String dashboard = "/dashboard";
  static const String memberManage = "/member_manage";
  static const String inactiveMemberManage = "/inactive_member_manage";
  static const String memberDetails = "/member_details";
  static const String memberEdit = "/member_edit";
  static const String memberRegister = "/member_register";
  static const String memberMassRegister = "/member_mass_register";
  static const String masterManage = "/master_manage";
  static const String masterRegister = "/master_register";
  static const String masterMassRegister = "/master_mass_register";
  static const String inactiveMasterManage = "/inactive_master_manage";
  static const String masterDetails = "/master_details";
  static const String masterEdit = "/master_edit";

  static const String companyManage = "/company_manage";
  static const String companyRegister = "/company_register";
  static const String companyMassRegister = "/company_mass_register";
  static const String inactiveCompanyManage = "/inactive_company_manage";
  static const String companyDetails = "/company_details";
  static const String companyEdit = "/company_edit";

  static const String contentManage = "/content_manage";
  static const String contentDetails = "/content_details";
  static const String contentManageList = "/content_manage_list";
  static const String contentRegister = "/content_register";
  static const String contentEdit = "/content_edit";
  static const String contentPracticeManage = "/content_practice_plan_manage";
  static const String practiceRegister = "/practice_register";
  static const String practiceEdit = "/practice_edit";
  static const String practiceDetails = "/practice_details";
  static const String contentChallengeManage = "/content_challenge_manage";
  static const String challengeDetails = "/challenge_details";
  static const String challengeEdit = "/challenge_edit";
  static const String challengeRegister = "/challenge_register";
  static const String activityManage = "/activity_manage";
  static const String settlementManage = "/settlement_manage";
  // static const String revenueShareManage = "/revenue_share_manage";
  static const String masterSettlementManage = "/master_settlement_manage";
  static const String termsManage = "/terms_manage";
  static const String adminSettings = "/admin_settings";
  static const String etcAdminSetting = '/etc_admin_settings';
  static const String subAdminSettings = '/sub_admin_settings';
  static const String subAdminRegister = '/sub_admin_register';
  static const String subAdminDetails = '/sub_admin_details';
  static const String subAdminEdit = '/sub_admin_edit';
  static const String activityHistory = "/activity_history";

  static String? initialRoute = auth;

  static List<GetPage> pages = [
    // GetPage(
    //   name: rootRoute,
    //   page: () {
    //     return SiteLayout();
    //   },
    // ),
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
      name: memberRegister,
      page: () => const MemberRegisterView(),
      bindings: [MemberRegisterBinding()],
    ),
    GetPage(
      name: memberMassRegister,
      page: () => const MemberMassRegisterView(),
      bindings: [MemberMassRegisterBinding()],
    ),
    GetPage(
      name: masterManage,
      page: () => const MasterManageView(),
      bindings: [MasterManageBinding()],
    ),
    GetPage(
      name: masterRegister,
      page: () => MasterRegisterView(),
      bindings: [MasterRegisterBinding()],
    ),
    GetPage(
      name: masterMassRegister,
      page: () => const MasterMassRegisterView(),
      bindings: [MasterMassRegisterBinding()],
    ),
    GetPage(
      name: inactiveMasterManage,
      page: () => const InactiveMasterManageView(),
      bindings: [InactiveMasterManageBinding()],
    ),
    GetPage(
      name: masterDetails,
      page: () => const MasterDetailsView(),
      bindings: [MasterDetailsBinding()],
    ),
    GetPage(
      name: masterEdit,
      page: () => const MasterEditView(),
      bindings: [MasterEditBinding()],
    ),

    GetPage(
      name: companyManage,
      page: () => const CompanyManageView(),
      bindings: [CompanyManageBinding()],
    ),
    GetPage(
      name: companyRegister,
      page: () => const CompanyRegisterView(),
      bindings: [CompanyRegisterBinding()],
    ),
    GetPage(
      name: companyMassRegister,
      page: () => const CompanyMassRegisterView(),
      bindings: [CompanyMassRegisterBinding()],
    ),
    GetPage(
      name: inactiveCompanyManage,
      page: () => const InactiveCompanyManageView(),
      bindings: [InactiveCompanyManageBinding()],
    ),
    GetPage(
      name: companyDetails,
      page: () => const CompanyDetailsView(),
      bindings: [CompanyDetailsBinding()],
    ),
    GetPage(
      name: companyEdit,
      page: () => const CompanyEditView(),
      bindings: [CompanyEditBinding()],
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
      name: contentPracticeManage,
      page: () => const PracticeManageView(),
      bindings: [PracticeManageBinding()],
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
      name: challengeRegister,
      page: () => const ChallengeRegisterView(),
      bindings: [ChallengeRegisterBinding()],
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
      name: etcAdminSetting,
      page: () => const EtcAdminSettingView(),
      bindings: [EtcAdminSettingBinding()],
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
    GetPage(
      name: settlementManage,
      page: () => const SettlementManageView(),
      bindings: [SettlementManageBinding()],
    ),
    GetPage(
      name: masterSettlementManage,
      page: () => const MasterSettlementManageView(),
      bindings: [MasterSettlementManageBinding()],
    ),
  ];
}
