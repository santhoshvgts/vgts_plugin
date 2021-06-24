

class InputValidator {

  static String? emptyValidator(String? value) {
    if (value!.isEmpty)
      return "Required !";

    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null) return "Required";

    if (value!.isEmpty)
      return "Required !";

    if (value!.length < 3)
      return "Name should be more than 3 letters";

    return null;
  }

  static String? numberValidator(String? value) {
    if (value!.isEmpty)
      return "Required !";

    return null;
  }

  static String? phoneValidator(String? value) {
    if (value!.length < 10)
      return "Invalid Phone Number";

    return null;
  }

  static String? emailValidator(String? value) {
    if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value!)) {
      return "Please enter a valid Email";
    }

    return null;
  }

}