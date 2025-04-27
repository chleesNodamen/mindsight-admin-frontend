import 'package:mindsight_admin_page/app_export.dart';

class EtcSettingController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  final receiveAllAlarm = true.obs;
  final emailAlarm = true.obs;
  final smsAlarm = true.obs;
  final noticeAlarm = true.obs;
  final qnaAlarm = true.obs;
  final contentAlarm = true.obs;
  final settlementAlarm = true.obs;

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

  void onAllAlarmToggle(bool value) {
    receiveAllAlarm.value = value;
  }

  void onEmailToggle(bool? value) {
    emailAlarm.value = value ?? false;
  }

  void onSmsToggle(bool? value) {
    smsAlarm.value = value ?? false;
  }

  void onNoticeToggle(bool? value) {
    noticeAlarm.value = value ?? false;
  }

  void onQnaToggle(bool? value) {
    qnaAlarm.value = value ?? false;
  }

  void onContentToggle(bool? value) {
    contentAlarm.value = value ?? false;
  }

  void onSettlementToggle(bool? value) {
    settlementAlarm.value = value ?? false;
  }

  void onSave() {
    Logger.info("Saved settings:");
    Logger.info("Receive All Alarm: ${receiveAllAlarm.value}");
    Logger.info("Email: ${emailAlarm.value}, SMS: ${smsAlarm.value}");
    Logger.info(
        "Notice: ${noticeAlarm.value}, QnA: ${qnaAlarm.value}, Content: ${contentAlarm.value}, Settlement: ${settlementAlarm.value}");
    Logger.info("Selected Language: ${selectedLanguage?.displayName}");
    Get.snackbar("Success", "Settings saved successfully");
  }

  void onCancel() {
    Get.back();
  }
}
