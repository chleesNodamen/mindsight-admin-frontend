enum ContentCategory {
  unknown('unknown status', 'UNKNOWN'),
  body('Body', 'BODY'),
  breath('Breath', 'BREATH'),
  mindfulness('Mindfulness', 'MINDFULNESS'),
  theory('Theory', 'THEORY');

  static int length = 4;

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
