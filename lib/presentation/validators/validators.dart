import 'package:mafia_game/utils/app_strings.dart';

class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailIsRequired;
    }
    final RegExp emailRegex =
    RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.enterValidEmailAddress;
    }
    return null;
  }

  static  String? validateText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailIsRequired;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.passwordIsRequired;
    }
    if (value.length < 6) {
      return AppStrings.passwordLengthRequirement;
    }
    return null;
  }
}
