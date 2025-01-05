enum ContentExposure {
  exposed('Exposure', true),
  nonExposed('Non Exposure', false);

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
