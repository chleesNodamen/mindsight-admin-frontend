enum FileExtension {
  srt('srt', 'SRT'),
  jpg('jpg', 'JPG'),
  mp4('mp4', 'MP4'),
  mp3('mp3', 'MP3'),
  wav('wav', 'WAV');

  final String _displayName;
  final String _keywordName;

  const FileExtension(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static FileExtension fromKeyword(String value) {
    return FileExtension.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => FileExtension.srt,
    );
  }
}
