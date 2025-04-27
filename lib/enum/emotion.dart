enum Emotion {
  satisfied('Satisfied', 'SATISFIED'),
  relaxed('Relaxed', 'RELAXED'),
  calm('Calm', 'CALM'),
  sleepy('Sleepy', 'SLEEPY'),
  tired('Tired', 'TIRED'),
  bored('Bored', 'BORED'),
  depressed('Depressed', 'DEPRESSED'),
  sad('Sad', 'SAD'),
  miserable('Miserable', 'MISERABLE'),
  upset('Upset', 'UPSET'),
  stressed('Stressed', 'STRESSED'),
  scared('Scared', 'SCARED'),
  annoyed('Annoyed', 'ANNOYED'),
  nervous('Nervous', 'NERVOUS'),
  angry('Angry', 'ANGRY'),
  alarmed('Alarmed', 'ALARMED'),
  surprised('Surprised', 'SURPRISED'),
  excited('Excited', 'EXCITED'),
  delighted('Delighted', 'DELIGHTED'),
  happy('Happy', 'HAPPY');

  final String _displayName;
  final String _keywordName;

  const Emotion(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static Emotion fromKeyword(String value) {
    return Emotion.values.firstWhere(
      (tag) => tag.keywordName == value,
      orElse: () => Emotion.happy,
    );
  }
}
