enum AccountRole {
  master('Master', 'MASTER'),
  admin('관리자', 'ADMIN');

  final String _displayName;
  final String _keywordName;

  const AccountRole(this._displayName, this._keywordName);

  String get displayName => _displayName;
  String get keywordName => _keywordName;

  static AccountRole? fromKeyword(String? value) {
    if (value == null) return null;
    for (AccountRole v in AccountRole.values) {
      if (v.keywordName == value) return v;
    }
    return null;
  }
}
