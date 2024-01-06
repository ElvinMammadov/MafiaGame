class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }

    // You can add a more sophisticated email validation logic if needed

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    // You can add additional password validation logic, e.g., minimum length, special characters, etc.

    return null;
  }
}
