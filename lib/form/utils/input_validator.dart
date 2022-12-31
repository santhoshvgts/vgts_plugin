

class InputValidator {

  static String? emptyValidator(String? value, { String? requiredText }) {
    if (value?.trim()?.isEmpty != false)
      return requiredText ?? "Required !";

    return null;
  }

  static String? nameValidator(String? value, { String? requiredText }) {
    if (value?.trim()?.isEmpty != false)
      return requiredText ?? "Required !";

    if (value!.trim().length < 3)
      return "Name should be more than 3 letters";

    return null;
  }

  static String? amountValidator(String? value, { String? requiredText }) {
    if (value?.trim()?.isEmpty != false){
      return requiredText ?? "Required !";
    }

    String trimmedValue = value?.trim().replaceAll(",", "").replaceAll("₹", "") ?? '';
    if (trimmedValue.isEmpty == true) {
      return requiredText ?? "Required !";
    }

    if (trimmedValue.contains(RegExp(r"[A-Z]"))){
      return "Invalid Amount Format";
    }
    return null;
  }
  
  static String? idValidator(String? value, { String? requiredText }) {
  if (value?.trim()?.isEmpty != false)
    return requiredText ?? "Required !";

  if (value!.trim()!.length < 4)
    return "School Id must be atleast 4 characters";

  return null;
}

  static String? numberValidator(String? value, { String? requiredText }) {
    if (value?.trim()?.isEmpty != false)
      return requiredText ?? "Required !";

    if ((value?.trim()?.split("-").length ?? 0) > 2) {
      return requiredText ?? "Invalid Number !";
    }

    return null;
  }

  static String? phoneValidator(String? value, { String? requiredText }) {
    if (value?.trim()?.isEmpty != false)
      return requiredText ?? "Required !";

    if (value!.length < 10)
      return "Invalid Phone Number";

    return null;
  }

  static String? emailValidator(String? value, { String? requiredText }) {
    if (value?.trim()?.isEmpty != false)
      return requiredText ?? "Required !";

    // r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"

    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)) {
      return "Please enter a valid Email";
    }

    return null;
  }

  static String? adhaarValidator(String? value, { String? requiredText }) {
    if (value?.trim()?.isEmpty != false)
      return requiredText ?? "Required !";

    if (!RegExp(r"[0-9]{4}[\\ ][0-9]{4}[\\ ][0-9]{4}$").hasMatch(value!)) {
      return "Please enter a valid Adhaar Number";
    }

    return null;
  }

  static String? panNumberValidator(String? value, { String? requiredText }) {
    if (value?.trim()?.isEmpty != false)
      return requiredText ?? "Required !";

    if (!RegExp(r"[A-Z]{5}[0-9]{4}[A-Z]{1}").hasMatch(value!)) {
      return "Please enter a valid PAN Number";
    }

    return null;
  }

  static String? gstNumberValidator(String? value, { String? requiredText }) {
    if (value?.trim()?.isEmpty != false)
      return requiredText ?? "Required !";

    if (value?.trim()?.length != 15) {
      return requiredText ?? "Invalid GST Number !";
    }

    if (!RegExp(r"[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[A-Z]{1}[0-9]{1}").hasMatch(value!)) {
      return "Please enter a valid GST Number";
    }

    return null;
  }

  static String? ifscValidator(String? value, { String? requiredText }) {
    if (value?.trim()?.isEmpty != false)
      return requiredText ?? "Required !";

    if (value?.trim()?.length != 11) {
      return requiredText ?? "Invalid IFSC Code !";
    }

    if (!RegExp(r"^[A-Z]{4}0[A-Z0-9]{6}$").hasMatch(value!)) {
      return "Please enter a valid IFSC Code";
    }

    return null;
  }


  static String? passwordValidator(String? value,{String? requiredText}) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value?.trim()?.isEmpty != false) {
      return requiredText ?? 'Required !';
    } else {
      if (!regex.hasMatch(value!)) {
        return "Password must be atleast 8 characters that include lowercase,\nuppercase character, special character & number ";
      } else {
        return null;
      }
    }
  }

}
