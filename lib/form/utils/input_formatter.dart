
import 'package:flutter/services.dart';

class InputFormatter {

  static List<TextInputFormatter> phoneNoFormatter = [
    FilteringTextInputFormatter.digitsOnly
  ];

  static List<TextInputFormatter> nameFormatter = [
    FilteringTextInputFormatter.deny(RegExp("[ ]{2}")),
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9\\ \\,]'))
  ];

  static List<TextInputFormatter> defaultFormatter = [
    FilteringTextInputFormatter.deny(new RegExp('[\\ ]')),
  ];

  static List<TextInputFormatter> numberFormatter = [
    FilteringTextInputFormatter.deny(RegExp("[.]{2}")),
    FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
  ];

  static List<TextInputFormatter> zipCodeFormatter = [
    FilteringTextInputFormatter.deny(RegExp("[-]{2}")),
    FilteringTextInputFormatter.allow(RegExp('[0-9-]')),
  ];

}