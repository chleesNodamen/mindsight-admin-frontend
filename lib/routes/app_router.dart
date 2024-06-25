import 'package:flutter/material.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_history_view.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_manage_view.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/admin_settings_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_view.dart';
import 'package:mindsight_admin_page/presentation/dashboard/dashboard_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_details_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_edit_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_manage_view.dart';
import 'package:mindsight_admin_page/presentation/terms_manage/terms_manage_view.dart';
import 'package:mindsight_admin_page/routes/app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case dashboardPageRoute:
      return _getPageRoute(const DashboardView());
    case memberManagePageRoute:
      return _getPageRoute(const MemberManageView());
    case inactiveMemberManagePageRoute:
      return _getPageRoute(const MemberManageView());
    case memberDetailsPageRoute:
      return _getPageRoute(const MemberDetailsView());
    case memberEditPageRoute:
      return _getPageRoute(const MemberEditView());
    case contentManagePageRoute:
      return _getPageRoute(const ContentManageView());
    case activityManagePageRoute:
      return _getPageRoute(const ActivityManageView());
    case activityHistoryPageRoute:
      return _getPageRoute(const ActivityHistoryView());
    case termsManagePageRoute:
      return _getPageRoute(const TermsManageView());
    case adminSettingsPageRoute:
      return _getPageRoute(const AdminSettingsView());
    default:
      return _getPageRoute(const DashboardView());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
