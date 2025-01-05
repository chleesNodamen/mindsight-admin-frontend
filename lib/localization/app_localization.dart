import 'package:get/get.dart';
import 'de_DE_translations.dart';
import 'es_ES_translations.dart';
import 'fr_FR_translations.dart';
import 'ja_JP_translations.dart';
import 'ko_KR_translations.dart';
import 'en_US_translations.dart';
import 'zh_CN_translations.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
        'ko_KR': koKR,
        'ja_JP': jaJP,
        'de_DE': deDE,
        'es_ES': esES,
        'fr_FR': frFR,
        'zh_CN': zhCN
      };
}
