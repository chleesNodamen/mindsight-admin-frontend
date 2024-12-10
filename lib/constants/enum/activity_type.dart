enum ActivityType {
  practice('연습 계획', 'PRACTICE'),
  challenge('챌린지', 'CHALLENGE');

  final String _displayName;
  final String _keywordName;

  const ActivityType(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static ActivityType? fromKeyword(String? value) {
    if (value == null) return null;
    for (ActivityType v in ActivityType.values) {
      if (v.keywordName == value) return v;
    }
    return null;
  }
}
