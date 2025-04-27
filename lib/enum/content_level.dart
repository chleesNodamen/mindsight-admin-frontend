enum ContentLevel {
  all('All', 'ALL'),
  // upper('Beginner', 'UPPER'),
  // middle('Intermediate', 'MIDDLE'),
  // lower('Advanced', 'LOWER');

  beginner('Beginner', 'BEGINNER'),
  intermediate('Intermediate', 'INTERMEDIATE'),
  advanced('Advanced', 'ADVANCED');

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
