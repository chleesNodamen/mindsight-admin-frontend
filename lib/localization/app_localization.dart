import 'package:get/get.dart';
import 'package:mindsight_admin_page/localization/en_us.dart';
import 'package:mindsight_admin_page/localization/ko_kr.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
        'ko_KR': koKR,
      };
}
