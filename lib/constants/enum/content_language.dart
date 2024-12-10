enum ContentLanguage {
  english('영어', 'ENGLISH'),
  korean('한국어', 'KOREAN'),
  japanese('일본어', 'JAPANESE');

  final String _displayName;
  final String _keywordName;

  const ContentLanguage(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static ContentLanguage fromKeyword(String value) {
    return ContentLanguage.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => ContentLanguage.english,
    );
  }
}
