class CorrectWordChecker {
  bool is8Characters = false;
  bool is1Symbol = false;
  bool isUpperLowerLetter = false;
  bool is1Number = false;
  CorrectWordChecker(String value) {
    check(value);
  }

  void check(String value) {
    is8Characters = false;
    is1Symbol = false;
    isUpperLowerLetter = false;
    is1Number = false;

    final validNumbers = RegExp(r'(\d+)');
    final validLowerAlphabet = RegExp(r'[a-z]');
    final validUpperAlphabet = RegExp(r'[A-Z]');
    final validSpecial = RegExp(r'^[a-zA-Z0-9 ]+$');

    //문자가 비었는지 확인
    if (value.isEmpty) {
      // 문자가 비었다면 모드 false로 리턴
      return;
    }

    //8자 이상인지 확인
    if (value.length >= 8) {
      is8Characters = true;
    } else {
      is8Characters = false;
    }

    //특수기호가 있는지 확인
    if (!validSpecial.hasMatch(value)) {
      is1Symbol = true;
    } else {
      is1Symbol = false;
    }

    //문자가 있는지 확인
    if (!validLowerAlphabet.hasMatch(value) ||
        !validUpperAlphabet.hasMatch(value)) {
      isUpperLowerLetter = false;
    } else {
      isUpperLowerLetter = true;
    }

    //숫자가 있는지 확인
    if (validNumbers.hasMatch(value)) {
      is1Number = true;
    } else {
      is1Number = false;
    }
  }
}
