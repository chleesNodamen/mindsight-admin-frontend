import 'package:mindsight_admin_page/app_export.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function() onTap;

  const SideMenuItem({Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            InkWell(
                onTap: onTap,
                onHover: (value) {
                  value
                      ? menuController.onHover(itemName)
                      : menuController.onHover("not hovering");
                },
                child: Container(
                  color: menuController.isHovering(itemName)
                      ? appTheme.white.withOpacity(0.4)
                      : Colors.transparent,
                  child: Row(
                    children: [
                      Visibility(
                        visible: menuController.isActive(itemName),
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: Container(
                          width: 4,
                          height: 72,
                          color: appTheme.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: menuController.returnIconFor(
                            itemName, menuController.isActive(itemName)),
                      ),
                      if (!menuController.isActive(itemName))
                        Flexible(
                            child: Text(
                          itemName,
                          style: CustomTextStyles.titleSmallWhite.copyWith(
                              color: appTheme.white.withOpacity(0.75)),
                        ))
                      else
                        Flexible(
                            child: Text(itemName,
                                style: CustomTextStyles.titleSmallWhite))
                    ],
                  ),
                )),
            menuController.isActive(itemName) &&
                    menuController.hasSubMenu(itemName)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: menuController.subMenuItems[itemName]!
                        .map((item) => Column(
                              children: [
                                InkWell(
                                  child: Container(
                                      color:
                                          menuController.isHovering(item.name)
                                              ? appTheme.white.withOpacity(0.4)
                                              : Colors.transparent,
                                      child: Text(item.name,
                                          style: menuController
                                                  .isActiveSubItem(item.name)
                                              ? CustomTextStyles.bodyMediumWhite
                                                  .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                )
                                              : CustomTextStyles.bodyMediumWhite
                                                  .copyWith(
                                                  color: Colors.white
                                                      .withOpacity(0.75),
                                                ))),
                                  onTap: () {
                                    Get.toNamed(item.route);
                                    menuController
                                        .changeActiveSubItem(item.name);
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                )
                              ],
                            ))
                        .toList())
                : const SizedBox.shrink()
          ],
        ));
  }
}
