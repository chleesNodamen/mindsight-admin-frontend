enum Situation {
  justRest('Just rest', 'JUST_REST'),
  sleep('Sleep', 'SLEEP'),
  workspace('Workspace', 'WORKSPACE'),
  movement('Movement', 'MOVEMENT');

  final String _displayName;
  final String _keywordName;

  const Situation(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static Situation fromKeyword(String value) {
    return Situation.values.firstWhere(
      (tag) => tag.keywordName == value,
      orElse: () => Situation.justRest,
    );
  }
}
