enum ContentType {
  // ContentCategory.body
  basicBody('기본 몸체', 'BASIC_BODY'),
  intermediateBody('중간 몸체', 'INTERMEDIATE_BODY'),
  advanceBody('숙련된 몸체', 'ADVANCE_BODY'),

  // ContentCategory.breath
  natureBreathing('자연 호흡', 'NATURE_BREATHING'),
  guidedMeditation('명상 안내', 'GUIDED_MEDITATION'),

  // ContentCategory.mindfulness
  mindfulArt('마음챙김 예술', 'MINDFUL_ART'),
  artWithMusic('음악이 있는 예술', 'ART_WITH_MUSIC'),
  nature('자연', 'NATURE'),
  kAsmr('K-ASMR', 'K_ASMR'),

  // ContentCategory.theory
  emotionManagement('감정 관리', 'EMOTION_MANAGEMENT'),
  philosophy('철학', 'PHILOSOPHY'),
  selfDevelopment('자기개발', 'SELF_DEVELOPMENT');

  final String _displayName;
  final String _keywordName;

  const ContentType(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static ContentType? fromKeyword(String value) {
    for (var type in ContentType.values) {
      if (type.keywordName == value) {
        return type;
      }
    }
    return null;
  }
}
