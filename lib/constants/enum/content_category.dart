enum ContentCategory {
  unknown('알수없음', 'UNKNOWN'),
  body('바디', 'BODY'),
  breath('호흡', 'BREATH'),
  mindfulness('마음챙김', 'MINDFULNESS'),
  theory('이론', 'THEORY');

  final String _displayName;
  final String _keywordName;

  const ContentCategory(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static ContentCategory fromKeyword(String value) {
    return ContentCategory.values.firstWhere(
      (category) => category.keywordName == value,
      orElse: () => ContentCategory.unknown,
    );
  }
}
