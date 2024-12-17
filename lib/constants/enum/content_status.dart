enum ContentStatus {
  approve('활성', true),
  disapprove('비활성', false);

  final String _displayName;
  final bool _keywordName;

  const ContentStatus(this._displayName, this._keywordName);

  String get displayName => _displayName;
  bool get keywordName => _keywordName;

  static ContentStatus fromKeyword(bool value) {
    return ContentStatus.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => ContentStatus.disapprove,
    );
  }
}
