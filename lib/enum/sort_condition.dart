enum SortCondition {
  registration('Order by Registration', 'REGISTRATION'),
  views('Order by Views', 'VIEWS'),
  likes('Order by Likes', 'LIKES'),
  mostParticipants('Order by Most Participants', 'MOST_PARTICIPANTS'),
  fewestParticipants('Order by Least Participants', 'FEWEST_PARTICIPANTS'),
  highestRatings('Order by Highest Rating', 'HIGHEST_RATINGS'),
  highestCompletionRate(
      'Order by Highest Completion Rate', 'HIGHEST_COMPLETION_RATE'),
  lowestCompletionRate(
      'Order by Lowest Completion Rate', 'LOWEST_COMPLETION_RATE');

  final String _displayName;
  final String _keywordName;

  const SortCondition(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static SortCondition fromKeyword(String? value) {
    if (value == null) return SortCondition.registration;
    return SortCondition.values.firstWhere(
      (v) => v.keywordName == value,
      orElse: () => SortCondition.registration,
    );
  }
}
