import 'package:mindsight_admin_page/utils/correct_word_checker.dart';
bool isValidEmail(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}
bool isValidPassword(
  String? inputString, {
  bool isRequired = false,
}) {
  final CorrectWordChecker wordChecker = CorrectWordChecker(inputString ?? '');

  return wordChecker.is8Characters &&
      wordChecker.isUpperLowerLetter &&
      wordChecker.is1Symbol;
}
