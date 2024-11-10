enum Category {
  unknown('알수없음', 'unknown'),
  body('바디', 'Body'),
  breath('호흡', 'Breath'),
  mindfulness('마음챙김', 'Mindfulness'),
  theory('이론', 'Theory');

  final String _displayName;
  final String _keywordName;

  const Category(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static Category fromKeyword(String value) {
    return Category.values.firstWhere(
      (category) => category.keywordName == value,
      orElse: () => Category.unknown,
    );
  }
}
