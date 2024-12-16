import 'package:high_level_application/utils/constants.dart';

class Validators {
  static bool isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  static bool isValidName(String name) {
    final nameRegex = RegExp(r'^[a-zA-Z]+$');
    return name.isNotEmpty && nameRegex.hasMatch(name);
  }

  static bool isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
    return passwordRegex.hasMatch(password);
  }

  static bool isEmptyField(String value) {
    return value.isEmpty;
  }

  static bool isNoteLimitExceeded(int count) {
    return count >= maxFreeNotes;
  }
}
