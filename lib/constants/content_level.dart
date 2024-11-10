enum ContentLevel {
  unknown('Unknown', 'UNKNOWN'),
  all('모두', 'ALL'),
  upper('상', 'UPPER'),
  middle('중', 'MIDDLE'),
  lower('하', 'LOWER');

  final String _displayName;
  final String _keywordName;

  const ContentLevel(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static ContentLevel fromKeyword(String value) {
    return ContentLevel.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => ContentLevel.unknown,
    );
  }
}
