enum Goal {
  improveHealth('Health Improvement', 'IMPROVE_HEALTH'),
  relaxingStretching('Comfortable Stretching', 'RELAXING_STRETCHING'),
  welnessAtWork('Workplace Well-being', 'WELNESS_AT_WORK'),
  regulateEmotions('Emotion Regulation', 'REGULATE_EMOTIONS'),
  fallAsleepEasily('Easy to Fall Asleep', 'FALL_ASLEEP_EASILY');

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
