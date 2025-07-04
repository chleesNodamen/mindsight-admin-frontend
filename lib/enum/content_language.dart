enum ContentLanguage {
  // afrikaans('Afrikaans', 'AFRIKAANS', 'af', 'ZA'),
  // albanian('Shqip', 'ALBANIAN', 'sq', 'AL'),
  // amharic('አማርኛ', 'AMHARIC', 'am', 'ET'),
  // arabic('العربية', 'ARABIC', 'ar', 'SA'),
  // armenian('Հայերեն', 'ARMENIAN', 'hy', 'AM'),
  // azerbaijani('Azərbaycan dili', 'AZERBAIJANI', 'az', 'AZ'),
  // basque('Euskara', 'BASQUE', 'eu', 'ES'),
  // belarusian('Беларуская', 'BELARUSIAN', 'be', 'BY'),
  // bengali('বাংলা', 'BENGALI', 'bn', 'BD'),
  // bosnian('Bosanski', 'BOSNIAN', 'bs', 'BA'),
  // bulgarian('Български', 'BULGARIAN', 'bg', 'BG'),
  // catalan('Català', 'CATALAN', 'ca', 'ES'),
  // cebuano('Cebuano', 'CEBUANO', 'ceb', 'PH'),
  // chichewa('Chichewa', 'CHICHEWA', 'ny', 'MW'),
  // chineseSimplified('简体中文', 'CHINESE_SIMPLIFIED', 'zh', 'CN'),
  // chineseTraditional('繁體中文', 'CHINESE_TRADITIONAL', 'zh', 'TW'),
  // corsican('Corsu', 'CORSICAN', 'co', 'FR'),
  // croatian('Hrvatski', 'CROATIAN', 'hr', 'HR'),
  // czech('Čeština', 'CZECH', 'cs', 'CZ'),
  // danish('Dansk', 'DANISH', 'da', 'DK'),
  // dutch('Nederlands', 'DUTCH', 'nl', 'NL'),
  // english('English', 'ENGLISH', 'en', 'US'),
  // esperanto('Esperanto', 'ESPERANTO', 'eo', ''),
  // estonian('Eesti', 'ESTONIAN', 'et', 'EE'),
  // filipino('Filipino', 'FILIPINO', 'tl', 'PH'),
  // finnish('Suomi', 'FINNISH', 'fi', 'FI'),
  // french('Français', 'FRENCH', 'fr', 'FR'),
  // frisian('Frysk', 'FRISIAN', 'fy', 'NL'),
  // galician('Galego', 'GALICIAN', 'gl', 'ES'),
  // georgian('ქართული', 'GEORGIAN', 'ka', 'GE'),
  // german('Deutsch', 'GERMAN', 'de', 'DE'),
  // greek('Ελληνικά', 'GREEK', 'el', 'GR'),
  // gujarati('ગુજરાતી', 'GUJARATI', 'gu', 'IN'),
  // haitianCreole('Kreyòl ayisyen', 'HAITIAN_CREOLE', 'ht', 'HT'),
  // hausa('Hausa', 'HAUSA', 'ha', 'NG'),
  // hawaiian('ʻŌlelo Hawaiʻi', 'HAWAIIAN', 'haw', 'US'),
  // hebrew('עברית', 'HEBREW', 'he', 'IL'),
  // hindi('हिन्दी', 'HINDI', 'hi', 'IN'),
  // hmong('Hmoob', 'HMONG', 'hmn', ''),
  // hungarian('Magyar', 'HUNGARIAN', 'hu', 'HU'),
  // icelandic('Íslenska', 'ICELANDIC', 'is', 'IS'),
  // igbo('Igbo', 'IGBO', 'ig', 'NG'),
  // indonesian('Bahasa Indonesia', 'INDONESIAN', 'id', 'ID'),
  // irish('Gaeilge', 'IRISH', 'ga', 'IE'),
  // italian('Italiano', 'ITALIAN', 'it', 'IT'),
  // japanese('日本語', 'JAPANESE', 'ja', 'JP'),
  // javanese('Basa Jawa', 'JAVANESE', 'jv', 'ID'),
  // kannada('ಕನ್ನಡ', 'KANNADA', 'kn', 'IN'),
  // kazakh('Қазақ тілі', 'KAZAKH', 'kk', 'KZ'),
  // khmer('ខ្មែរ', 'KHMER', 'km', 'KH'),
  // korean('한국어', 'KOREAN', 'ko', 'KR'),
  // kurdish('Kurdî', 'KURDISH', 'ku', 'TR'),
  // kyrgyz('Кыргызча', 'KYRGYZ', 'ky', 'KG'),
  // lao('ລາວ', 'LAO', 'lo', 'LA'),
  // latin('Latina', 'LATIN', 'la', ''),
  // latvian('Latviešu', 'LATVIAN', 'lv', 'LV'),
  // lithuanian('Lietuvių', 'LITHUANIAN', 'lt', 'LT'),
  // luxembourgish('Lëtzebuergesch', 'LUXEMBOURGISH', 'lb', 'LU'),
  // macedonian('Македонски', 'MACEDONIAN', 'mk', 'MK'),
  // malagasy('Malagasy', 'MALAGASY', 'mg', 'MG'),
  // malay('Bahasa Melayu', 'MALAY', 'ms', 'MY'),
  // malayalam('മലയാളം', 'MALAYALAM', 'ml', 'IN'),
  // maltese('Malti', 'MALTESE', 'mt', 'MT'),
  // maori('Māori', 'MAORI', 'mi', 'NZ'),
  // marathi('मराठी', 'MARATHI', 'mr', 'IN'),
  // mongolian('Монгол', 'MONGOLIAN', 'mn', 'MN'),
  // myanmar('မြန်မာ', 'MYANMAR', 'my', 'MM'),
  // nepali('नेपाली', 'NEPALI', 'ne', 'NP'),
  // norwegian('Norsk', 'NORWEGIAN', 'no', 'NO'),
  // odia('ଓଡ଼ିଆ', 'ODIA', 'or', 'IN'),
  // pashto('پښتو', 'PASHTO', 'ps', 'AF'),
  // persian('فارسی', 'PERSIAN', 'fa', 'IR'),
  // polish('Polski', 'POLISH', 'pl', 'PL'),
  // portuguese('Português', 'PORTUGUESE', 'pt', 'PT'),
  // punjabi('ਪੰਜਾਬੀ', 'PUNJABI', 'pa', 'IN'),
  // romanian('Română', 'ROMANIAN', 'ro', 'RO'),
  // russian('Русский', 'RUSSIAN', 'ru', 'RU'),
  // samoan('Gagana Sāmoa', 'SAMOAN', 'sm', 'WS'),
  // scotsGaelic('Gàidhlig', 'SCOTS_GAELIC', 'gd', 'GB'),
  // serbian('Српски', 'SERBIAN', 'sr', 'RS'),
  // sesotho('Sesotho', 'SESOTHO', 'st', 'LS'),
  // shona('Shona', 'SHONA', 'sn', 'ZW'),
  // sindhi('سنڌي', 'SINDHI', 'sd', 'PK'),
  // sinhala('සිංහල', 'SINHALA', 'si', 'LK'),
  // slovak('Slovenčina', 'SLOVAK', 'sk', 'SK'),
  // slovenian('Slovenščina', 'SLOVENIAN', 'sl', 'SI'),
  // somali('Soomaaliga', 'SOMALI', 'so', 'SO'),
  // spanish('Español', 'SPANISH', 'es', 'ES'),
  // sundanese('Basa Sunda', 'SUNDANESE', 'su', 'ID'),
  // swahili('Kiswahili', 'SWAHILI', 'sw', 'TZ'),
  // swedish('Svenska', 'SWEDISH', 'sv', 'SE'),
  // tajik('Тоҷикӣ', 'TAJIK', 'tg', 'TJ'),
  // tamil('தமிழ்', 'TAMIL', 'ta', 'IN'),
  // telugu('తెలుగు', 'TELUGU', 'te', 'IN'),
  // thai('ไทย', 'THAI', 'th', 'TH'),
  // turkish('Türkçe', 'TURKISH', 'tr', 'TR'),
  // ukrainian('Українська', 'UKRAINIAN', 'uk', 'UA'),
  // urdu('اردو', 'URDU', 'ur', 'PK'),
  // uzbek('Oʻzbekcha', 'UZBEK', 'uz', 'UZ'),
  // vietnamese('Tiếng Việt', 'VIETNAMESE', 'vi', 'VN'),
  // welsh('Cymraeg', 'WELSH', 'cy', 'GB'),
  // xhosa('isiXhosa', 'XHOSA', 'xh', 'ZA'),
  // yiddish('ייִדיש', 'YIDDISH', 'yi', 'IL'),
  // yoruba('Yorùbá', 'YORUBA', 'yo', 'NG'),
  // zulu('isiZulu', 'ZULU', 'zu', 'ZA');

  korean('한국어', 'KOREAN', 'ko', 'KR'),
  english('English', 'ENGLISH', 'en', 'US');

  final String _displayName;
  final String _keywordName;
  final String _languageCode;
  final String _countryCode;

  const ContentLanguage(
    this._displayName,
    this._keywordName,
    this._languageCode,
    this._countryCode,
  );

  String get displayName => _displayName;
  String get keywordName => _keywordName;
  String get languageCode => _languageCode;
  String get countryCode => _countryCode;

  static ContentLanguage fromKeyword(String value) {
    return ContentLanguage.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => ContentLanguage.english,
    );
  }

  static ContentLanguage fromLanguageCode(String code) {
    return ContentLanguage.values.firstWhere(
      (v) => v.languageCode == code,
      orElse: () => ContentLanguage.english,
    );
  }
}
