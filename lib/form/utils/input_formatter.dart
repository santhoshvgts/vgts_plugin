
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InputFormatter {

  static List<TextInputFormatter> phoneNoFormatter = [
    FilteringTextInputFormatter.digitsOnly,
  ];

  static List<TextInputFormatter> adhaarNoFormatter = [
    FilteringTextInputFormatter.allow(RegExp('[0-9\\ ]')),
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

  static List<TextInputFormatter> nameStrictFormatter = [
    FilteringTextInputFormatter.deny(RegExp("[ ]{2}")),
    FilteringTextInputFormatter.deny(RegExp("^[\\ ]{0,1}")),
    FilteringTextInputFormatter.deny(RegExp("^[0-9]{0,3}")),
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z\\ ]'))
  ];

  static List<TextInputFormatter> defaultFormatter = [
    FilteringTextInputFormatter.deny(new RegExp('[\\ ]')),
  ];

  static List<TextInputFormatter> numberFormatter = [
    FilteringTextInputFormatter.deny(RegExp("[-]{2}")),
    FilteringTextInputFormatter.allow(RegExp(r'[0-9-]{1}[0-9]*\.?[0-9]*$')),
    FilteringTextInputFormatter.deny(RegExp("[-]{1}[.]{1}")),
  ];

  static List<TextInputFormatter> zipCodeFormatter = [
    FilteringTextInputFormatter.deny(RegExp("[-]{2}")),
    FilteringTextInputFormatter.allow(RegExp('[0-9-]')),
  ];

  @deprecated
  static List<TextInputFormatter> ifscFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'[A-Z]{4}[A-Z0-9]{6}$')),
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

class CurrencyInputFormatter extends TextInputFormatter {

  CurrencyInputFormatter({this.maxDigits = 10});
  final int maxDigits;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    if (newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    final oldValueText = oldValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    NumberFormat formatter = NumberFormat.currency(
      name: "INR",
      locale: 'en_IN',
      decimalDigits: 0,
      symbol: '₹',
    );

    String newValueText = '';
    try {
      newValueText = formatter.parse(newValue.text).toString();
    } catch(ex) {
    }

    if (oldValueText == newValue.text) {
      newValueText = newValueText.substring(0, newValue.selection.end - 1) + newValueText.substring(newValue.selection.end, newValueText.length);
    }

    String newText = "";
    if (newValueText.isNotEmpty) {
      double value = double.parse(newValueText);
      newText = formatter.format(value);
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
