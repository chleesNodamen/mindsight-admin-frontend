enum Category {
  unknown('Unknown', 'unknown'),
  body('Body', 'Body'),
  breath('Breath', 'Breath'),
  mindfulness('Mindfulness', 'Mindfulness'),
  theory('Theory', 'Theory');

  final String displayName;
  final String keywordName;

  const Category(this.displayName, this.keywordName);

  String toDisplayName() => displayName;
  String toKeywordName() => keywordName;

  static Category fromKeyword(String value) {
    return Category.values.firstWhere(
      (category) => category.keywordName == value,
      orElse: () => Category.unknown,
    );
  }
}
