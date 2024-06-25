import 'package:flutter/material.dart';
import 'package:mindsight_admin_page/app_export.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final Function()? onTap;
  const HorizontalMenuItem({super.key, required this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Obx(() => Column(
      children: [
        InkWell(
            onTap: onTap,
            onHover: (value) {
              value
                  ? menuController.onHover(itemName)
                  : menuController.onHover("not hovering");
            },
            child:  Container(
                  color: menuController.isHovering(itemName)
                      ? appTheme.white.withOpacity(0.4)
                      : Colors.transparent,
                  child: Row(
                    children: [
                      Visibility(
                        visible: 
                            menuController.isActive(itemName),
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
                        child: menuController.returnIconFor(itemName, menuController.isActive(itemName)),
                      ),
                      if (!menuController.isActive(itemName))
                        Flexible(
                            child: Text(
                                itemName,
                                style: CustomTextStyles.titleSmallWhite.copyWith(color: appTheme.white.withOpacity(0.75)),
                        ))
                      else
                        Flexible(
                            child: Text(
                                itemName,
                                style: CustomTextStyles.titleSmallWhite
                        ))
                    ],
                  ),
        
                )),
                menuController.isActive(itemName) && menuController.hasSubMenu(itemName) ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: menuController.subMenuItems[itemName]!
                  .map((item) => Column(
                    children: [
                      GestureDetector(child: Text(item, style: CustomTextStyles.bodyMediumWhite,)),
                      const SizedBox(height: 16,)
                    ],
                  ))
                  .toList()
                    ) : const SizedBox.shrink()
      ],
    ));
  }
}
