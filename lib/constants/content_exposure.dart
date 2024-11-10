enum ContentExposured {
  unknown('Unknown', 'UNKNOWN'),
  exposed('노출', 'EXPOSED'),
  nonExposed('비 노출', 'NON_EXPOSURED');

  final String _displayName;
  final String _keywordName;

  const ContentExposured(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static ContentExposured fromKeyword(String value) {
    return ContentExposured.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => ContentExposured.unknown,
    );
  }
}
