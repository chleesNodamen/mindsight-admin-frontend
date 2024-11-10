enum ContentLanguage {
  unknown('없음', 'UNKNOWN'),
  english('영어', 'ALL'),
  korean('한국어', 'UPPER'),
  japanese('일본어', 'MIDDLE');

  final String _displayName;
  final String _keywordName;

  const ContentLanguage(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static ContentLanguage fromKeyword(String value) {
    return ContentLanguage.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => ContentLanguage.unknown,
    );
  }
}
