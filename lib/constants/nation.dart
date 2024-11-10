enum Nation {
  unknown('알수없음', 'UNKNOWN'),
  us('미국', 'US'),
  korea('한국', 'KOREA'),
  japan('일본', 'JAPAN');

  final String _displayName;
  final String _keywordName;

  const Nation(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static Nation fromKeyword(String value) {
    return Nation.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => Nation.unknown,
    );
  }
}
