class Validator {
  Validator._();

  static bool validateEmpty(String value) {
    if (value.isEmpty) {
      return true;
    }
    return false;
  }

  static bool validateNonEmpty(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  static bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (!value.contains('@')) {
      return false;
    }
    if (value.length < 5) {
      return false;
    }
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
