
import 'package:flutter/services.dart';

class InputFormatter {

  static List<TextInputFormatter> phoneNoFormatter = [
    FilteringTextInputFormatter.digitsOnly,
  ];

  static List<TextInputFormatter> adhaarNoFormatter = [
    FilteringTextInputFormatter.allow(RegExp('[0-9\\ \\,]')),
    MaskedTextInputFormatter(
      mask: 'xxxx xxxx xxxx',
      separator: ' ',
    ),
  ];

  static List<TextInputFormatter> vehicleFormatter = [
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9\\-]')),
    MaskedTextInputFormatter(
      mask: 'xx-xx-xx-xxxx',
      separator: '-',
    ),
  ];

  static List<TextInputFormatter> nameFormatter = [
    FilteringTextInputFormatter.deny(RegExp("[ ]{2}")),
    // FilteringTextInputFormatter.deny(RegExp("[,]{1}")),
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9\\ ]'))
  ];

  static List<TextInputFormatter> defaultFormatter = [
    FilteringTextInputFormatter.deny(new RegExp('[\\ ]')),
  ];

  static List<TextInputFormatter> numberFormatter = [
    // FilteringTextInputFormatter.deny(RegExp("[.]{2}")),
    FilteringTextInputFormatter.deny(RegExp("[-]{2}")),
    // FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),
    FilteringTextInputFormatter.allow(RegExp(r'[0-9\\-]*\.?[0-9]*$')),
  ];

  static List<TextInputFormatter> zipCodeFormatter = [
    FilteringTextInputFormatter.deny(RegExp("[-]{2}")),
    FilteringTextInputFormatter.allow(RegExp('[0-9-]')),
  ];

}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.length > 0) {
      if(newValue.text.length > oldValue.text.length) {
        if(newValue.text.length > mask.length) return oldValue;
        if(newValue.text.length < mask.length && mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length-1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
