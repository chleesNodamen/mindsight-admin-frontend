enum ContentExposure {
  exposed('노출', true),
  nonExposed('비노출', false);

  final String _displayName;
  final bool _keywordName;

  const ContentExposure(this._displayName, this._keywordName);

  String get displayName => _displayName;
  bool get keywordName => _keywordName;

  static ContentExposure fromKeyword(bool value) {
    return ContentExposure.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => ContentExposure.nonExposed,
    );
  }
}
