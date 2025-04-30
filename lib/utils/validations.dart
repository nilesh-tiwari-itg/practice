class Validations {
  static bool nameValidation(String? value) {
    if (value == null || value.isEmpty) return false;
    RegExp regExp = RegExp(r'^[a-zA-Z0-9]+$');
    return regExp.hasMatch(value);
  }

  static bool emailValidation(String? value) {
    if (value == null || value.isEmpty) return false;
    String pattern = '[a-z0-9]+@[a-z]+.[a-z]{2,3}';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool passwordValidation(String? value) {
    if (value == null || value.isEmpty) return false;
    RegExp regExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$');
    return regExp.hasMatch(value);
  }

  static bool mobileValidation(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.length < 10 ||
        value.length > 15) return false;
    return true;
  }
}
