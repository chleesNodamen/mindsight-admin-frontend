import 'package:mindsight_admin_page/app_export.dart';

class EtcAdminSettingController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  ContentLanguage selectedLanguage = ContentLanguage.english;

  @override
  Future<void> onInit() async {
    super.onInit();

    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    selectedLanguage = PrefUtils.to.getLocaleLanguage();

    isInited.value = true;
    isLoading.value = false;
  }

  void onLanguage(ContentLanguage? newValue) {
    selectedLanguage = newValue!;
    Get.updateLocale(Locale(newValue.languageCode));

    PrefUtils.to.setLocaleLanguage(newValue);
  }
}
