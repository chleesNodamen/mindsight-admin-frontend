enum ContentType {
  unknown('Unknown', 'UNKNOWN'),
  basicBody('기본 몸체', 'BASIC_BODY'),
  intermediateBody('중간 몸체', 'INTERMEDIATE_BODY'),
  advanceBody('숙련된 몸체', 'ADVANCE_BODY'),
  natureBreathing('자연 호흡', 'NATURE_BREATHING'),
  guidedMeditation('명상 안내', 'GUIDED_MEDITATION'),
  mindfulArt('마음챙김 예술', 'MINDFUL_ART'),
  artWithMusic('음악이 있는 예술', 'ART_WITH_MUSIC'),
  nature('자연', 'NATURE'),
  kAsmr('K-ASMR', 'K_ASMR'),
  emotionManagement('감정관리', 'EMOTION_MANAGEMENT'),
  philosophy('철학', 'PHILOSOPHY'),
  selfDevelopment('자기개발', 'SELF_DEVELOPMENT');

  final String _displayName;
  final String _keywordName;

  const ContentType(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static ContentType fromKeyword(String value) {
    return ContentType.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => ContentType.unknown,
    );
  }
}
