enum Gender {
  unknown('알수없음', 'UNKNOWN'),
  male('남자', 'MALE'),
  female('여자', 'FEMALE'),
  nonbinary('논바이너리', 'NONBINARY');

  final String _displayName;
  final String _keywordName;

  const Gender(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static Gender? fromKeyword(String? value) {
    if (value == null) return null;
    for (Gender gender in Gender.values) {
      if (gender.keywordName == value) return gender;
    }
    return null;
  }
}
