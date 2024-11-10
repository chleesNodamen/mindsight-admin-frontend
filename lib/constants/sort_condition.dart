enum SortCondition {
  unknown('알수없음', 'UNKNOWN'),
  registration('등록 순', 'REGISTRATION'),
  views('조회 순', 'VIEWS'),
  likes('좋아요 순', 'LIKES'),
  mostParticipants('참여자 많은 순', 'MOST_PARTICIPANTS'),
  fewestParticipants('참여자 낮은 순', 'FEWEST_PARTICIPANTS'),
  highestRatings('별점 높은 순', 'HIGHEST_RATINGS'),
  highestCompletionRate('완료율 높은 순', 'HIGHEST_COMPLETION_RATE'),
  lowestCompletionRate('완료율 낮은 순', 'LOWEST_COMPLETION_RATE');

  final String _displayName;
  final String _keywordName;

  const SortCondition(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static SortCondition fromKeyword(String? value) {
    if (value == null) return SortCondition.unknown;
    return SortCondition.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => SortCondition.unknown,
    );
  }
}
