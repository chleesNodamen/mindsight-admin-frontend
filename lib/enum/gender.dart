enum Gender {
  male('Male', 'MALE'),
  female('Female', 'FEMALE'),
  nonbinary('Nonbinary', 'NONBINARY');

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
