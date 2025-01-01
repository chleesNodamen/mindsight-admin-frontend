import 'package:mindsight_admin_page/app_export.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function() onTap;

  const SideMenuItem({super.key, required this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: onTap,
                onHover: (value) {
                  value
                      ? SideMenuController.to.onHover(itemName)
                      : SideMenuController.to.onHover("not hovering".tr);
                },
                child: Container(
                  color: SideMenuController.to.isHovering(itemName)
                      ? appTheme.white.withOpacity(0.4)
                      : Colors.transparent,
                  child: Row(
                    children: [
                      Visibility(
                        visible: SideMenuController.to.isActive(itemName),
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
                        child: SideMenuController.to.returnIconFor(
                            itemName, SideMenuController.to.isActive(itemName)),
                      ),
                      if (!SideMenuController.to.isActive(itemName))
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
            SideMenuController.to.isActive(itemName) &&
                    SideMenuController.to.hasSubMenu(itemName)
                ? Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: SideMenuController.to.subMenuItems[itemName]!
                            .map((item) => Column(
                                  children: [
                                    InkWell(
                                      child: Container(
                                          color: SideMenuController.to
                                                  .isHovering(item.name)
                                              ? appTheme.white.withOpacity(0.4)
                                              : Colors.transparent,
                                          child: Text(item.name,
                                              style: SideMenuController.to
                                                      .isActiveSubItem(
                                                          item.name)
                                                  ? CustomTextStyles
                                                      .bodyMediumWhiteBold
                                                  : CustomTextStyles
                                                      .bodyMediumWhite
                                                      .copyWith(
                                                      color: Colors.white
                                                          .withOpacity(0.75),
                                                    ))),
                                      onTap: () {
                                        Get.offAllNamed(item.route);
                                        item.inited();
                                        SideMenuController.to
                                            .changeActiveSubItem(item.name);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    )
                                  ],
                                ))
                            .toList()),
                  )
                : const SizedBox.shrink()
          ],
        ));
  }
}
