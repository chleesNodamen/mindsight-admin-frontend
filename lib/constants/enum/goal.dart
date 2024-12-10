enum Goal {
  improveHealth('건강 향상', 'IMPROVE_HEALTH'),
  relaxingStretching('편안한 스트레칭', 'RELAXING_STRETCHING'),
  welnessAtWork('직장에서의 웰빙', 'WELNESS_AT_WORK'),
  regulateEmotions('감정 조절', 'REGULATE_EMOTIONS'),
  fallAsleepEasily('쉽게 잠들기', 'FALL_ASLEEP_EASILY');

  final String _displayName;
  final String _keywordName;

  const Goal(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static Goal fromKeyword(String value) {
    return Goal.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => Goal.improveHealth,
    );
  }
}
