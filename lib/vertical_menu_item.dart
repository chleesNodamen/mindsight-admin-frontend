import 'app_export.dart';

class VertticalMenuItem extends StatelessWidget {
  final String itemName;
  final Function()? onTap;
  const VertticalMenuItem({super.key, required this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        // onHover: (value) {
        //   value
        //       ? menuController.onHover(itemName)
        //       : menuController.onHover("not hovering");
        // },
        child: Obx(() => Container(
              color: menuController.isHovering(itemName)
                  ? appTheme.white
                  : appTheme.white.withOpacity(0.75),
              child: Row(
                children: [
                  Visibility(
                    visible: menuController.isHovering(itemName) ||
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
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: menuController.returnIconFor(itemName, menuController.isActive(itemName)),
                        ),
                        if (!menuController.isActive(itemName))
                          Flexible(
                              child: Text(
                            itemName,
                            style: TextStyle(
color: Colors.white.withOpacity(0.75),
fontSize: 18,
fontFamily: 'Pretendard',
fontWeight: FontWeight.w700,
height: 0.07,
),
                          ))
                        else
                          Flexible(
                              child: Text(
                            itemName,
                            style: const TextStyle(
color: Colors.white,
fontSize: 18,
fontFamily: 'Pretendard',
fontWeight: FontWeight.w700,
height: 0.07,
),
                          ))
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
