import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_history_controller.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_manage_controller.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_controller.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = dashboardPageDisplayName.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    switch (itemName) {
      case contentManagePageDisplayName:
        Get.lazyPut(() => ContentManageController());
        case activityManagePageDisplayName:
        Get.lazyPut(() => ActivityManageController());
        case activityHistoryPageDisplayName:
        Get.lazyPut(() => ActivityHistoryController());
    }
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;

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
      case termsManagePageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.policy.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
      case adminSettingsPageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.settings.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
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
}
