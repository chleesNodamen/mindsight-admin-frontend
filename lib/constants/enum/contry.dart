enum Contry {
  us('미국', 'US'),
  korea('한국', 'KOREA'),
  japan('일본', 'JAPAN');

  final String _displayName;
  final String _keywordName;

  const Contry(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static Contry fromKeyword(String value) {
    return Contry.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => Contry.us,
    );
  }
}
