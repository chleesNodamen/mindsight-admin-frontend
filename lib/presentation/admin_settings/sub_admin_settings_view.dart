import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_settings_controller.dart';

class SubAdminSettingsView extends GetWidget<SubAdminSettingsController> {
  const SubAdminSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PageLoadingIndicator(
        isLoading: controller.isLoading.value,
        child: controller.isInited.value
            ? ResponsiveWidget(
                largeScreen: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SideMenu(),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                            width: 30.adaptSize,
                            height: 30.adaptSize,
                            child: const CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
