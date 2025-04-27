enum ContentCategory {
  body('Body', 'BODY'),
  breath('Breath', 'BREATH'),
  theory('Theory', 'THEORY'),
  mindfulArt('Mindful Art', 'MINDFUL_ART'),
  asmr('ASMR', 'ASMR'),
  artAndMusic('Art & Music', 'ART_AND_MUSIC');

  final String _displayName;
  final String _keywordName;

  const ContentCategory(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static ContentCategory fromKeyword(String value) {
    return ContentCategory.values.firstWhere(
      (category) => category.keywordName == value,
      orElse: () => ContentCategory.body,
    );
  }
}
