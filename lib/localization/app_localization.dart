import 'package:get/get.dart';
import 'package:mindsight_admin_page/localization/ja_jp/ja_jp_translations.dart';
import 'package:mindsight_admin_page/localization/ko_kr/ko_kr_translations.dart';
import 'en_us/en_us_translations.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {'en_US': enUs, 'ko_Kr': koKr, 'ja_Jp': jaJp};
}
