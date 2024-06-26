import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_manage/practice_plan_manage_controller.dart';

class PracticePlanManageView extends GetWidget<PracticePlanManageController> {
  const PracticePlanManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ResponsiveWidget(
        largeScreen: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SideMenu(),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Column()),
            ),
          ],
        ),
      ),
    );
  }
}
