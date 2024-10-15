import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/member_manage/inactive_member_manage_controller.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_manage_controller.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/settlement_manage_controller.dart';

class SubMenuItem {
  final String name;
  final String route;
  final Function inited;

  SubMenuItem(this.name, this.route, this.inited);
}

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = dashboardPageDisplayName.obs;
  Rx<String>? activeSubItem;
  Map<String, List<SubMenuItem>> subMenuItems = {
    memberManagePageDisplayName: [
      SubMenuItem(memberManagePageSubMenuDisplayName, AppRoutes.memberManage,
          () {
        if (Get.isRegistered<MemberManageController>()) {
          Get.find<MemberManageController>().loadData();
        }
      }),
      SubMenuItem(
          inactiveMemberManagePageDisplayName, AppRoutes.inactiveMemberManage,
          () {
        if (Get.isRegistered<InactiveMemberManageController>()) {
          Get.find<InactiveMemberManageController>().loadData();
        }
      }),
    ],
    contentManagePageDisplayName: [
      SubMenuItem(contentManageContentDisplayName, AppRoutes.contentManage, () {
        if (Get.isRegistered<MemberManageController>()) {
          Get.find<MemberManageController>().loadData();
        }
      }),
      SubMenuItem(
          contentPracticePlanDisplayName, AppRoutes.contentPracticePlanManage,
          () {
        if (Get.isRegistered<InactiveMemberManageController>()) {
          Get.find<InactiveMemberManageController>().loadData();
        }
      }),
      SubMenuItem(contentChallengeDisplayName, AppRoutes.contentChallengeManage,
          () {
        if (Get.isRegistered<InactiveMemberManageController>()) {
          Get.find<InactiveMemberManageController>().loadData();
        }
      }),
    ],
    adminSettingsPageDisplayName: [
      SubMenuItem(myAccountManageDisplayName, AppRoutes.adminSettings, () {
        if (Get.isRegistered<MemberManageController>()) {
          Get.find<MemberManageController>().loadData();
        }
      }),
      SubMenuItem(subAdminSettingsDisplayName, AppRoutes.subAdminSettings, () {
        if (Get.isRegistered<InactiveMemberManageController>()) {
          Get.find<InactiveMemberManageController>().loadData();
        }
      }),
    ],
    settlementManagePageDisplayName: [
      SubMenuItem(
          settlementManagePageSubMenuDisplayName, AppRoutes.settlementManage,
          () {
        if (Get.isRegistered<SettlementManageController>()) {
          Get.find<SettlementManageController>().loadData();
        }
      }),
      SubMenuItem(
          revenueShareManagePageDisplayName, AppRoutes.revenueShareManage, () {
        if (Get.isRegistered<SettlementManageController>()) {
          Get.find<SettlementManageController>().loadData();
        }
      }),
    ],
  };

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    // switch (itemName) {
    //   case contentManagePageDisplayName:
    //     Get.lazyPut(() => ContentManageController());
    //   case activityManagePageDisplayName:
    //     Get.lazyPut(() => ActivityManageController());
    //   case memberManagePageDisplayName:
    //     Get.lazyPut(() => MemberManageController());
    //   case memberDetailsPageDisplayName:
    //     Get.lazyPut(() => MemberDetailsController());
    //   case memberEditPageDisplayName:
    //     Get.lazyPut(() => MemberEditController());
    // }
    activeItem.value = itemName;
  }

  setActiveSubItem(String itemName) {
    activeSubItem = subMenuItems[itemName]![0].name.obs;
  }

  changeActiveSubItem(String itemName) {
    activeSubItem = itemName.obs;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  onHoverSubItem(String itemName) {
    if (!isActiveSubItem(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;

  isActiveSubItem(String itemName) => activeSubItem!.value == itemName;

  Widget returnIconFor(String itemName, bool full) {
    switch (itemName) {
      case dashboardPageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.dashboard.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
      case memberManagePageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.member.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
      case contentManagePageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.content.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
      case activityManagePageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.feedback.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
      case adminSettingsPageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.settings.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
      case settlementManagePageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.aabbcc.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
      // case authenticationPageDisplayName:
      //   return _customIcon(Icons.exit_to_app, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 22, color: appTheme.black);

    return Icon(
      icon,
      color: isHovering(itemName) ? appTheme.black : appTheme.grayScale10,
    );
  }

  bool hasSubMenu(String itemName) {
    return subMenuItems.containsKey(itemName);
  }
}
