import 'package:flutter_svg/svg.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/icon_constant.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_controller.dart';

class ContentManageView extends GetWidget<ContentManageController> {
  const ContentManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [InkWell(child: SvgPicture.asset(IconConstant.add),)]);
  }
}
