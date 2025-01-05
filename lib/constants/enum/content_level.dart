enum ContentLevel {
  all('All', 'ALL'),
  upper('Upper', 'UPPER'),
  middle('Middle', 'MIDDLE'),
  lower('Lower', 'LOWER');

  final String _displayName;
  final String _keywordName;

  const ContentLevel(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static ContentLevel? fromKeyword(String? value) {
    if (value == null) {
      return null;
    }
    for (var v in ContentLevel.values) {
      if (v.keywordName == value) {
        return v;
      }
    }
    return null;
  }

  // static ContentLevel? fromKeyword(String value) {
  //   return ContentLevel.values.firstWhere(
  //     (v) => v.keywordName == value;

  //   );
  // }
}
