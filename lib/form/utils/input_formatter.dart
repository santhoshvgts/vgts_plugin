import 'package:flutter/services.dart';

import '../../constants/vgts_constant.dart';

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

  static List<TextInputFormatter> gstNoFormatter = [
    FilteringTextInputFormatter.allow(
        RegExp(r"[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[A-Z]{1}[0-9]{1}")),
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
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
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
  CurrencyInputFormatter({this.maxDigits = 10, this.isSubtract = false});
  final int maxDigits;
  final bool isSubtract;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    if (newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }
    final formatter = VgtsConstant.currencyFormatter(
        decimalDigits: 0, isSubtract: isSubtract);
    final oldValueText = oldValue.text.replaceAll(RegExp(r'[^0-9].'), '');

    String newValueText = '';
    try {
      newValueText = formatter.parse(newValue.text).toString();
    } catch (ex) {}

    if (oldValueText == newValue.text) {
      newValueText = newValueText.substring(0, newValue.selection.end - 1) +
          newValueText.substring(newValue.selection.end, newValueText.length);
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

class AmountInputFormatter extends TextInputFormatter {
  AmountInputFormatter(
      {this.decimalRange = 2,
      this.maxDigits = 6,
      this.isSymbol = true,
      this.price});
  final int decimalRange;
  final int? maxDigits;
  final bool isSymbol;
  final double? price;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String nValue = newValue.text;
    TextSelection nSelection = newValue.selection;

    Pattern p = RegExp(r'(\d+\.?)|(\.?\d+)|(\.?)');
    nValue = p
        .allMatches(nValue)
        .map<String>((Match match) => match.group(0)!)
        .join();

    final oldText =
        oldValue.text.replaceAll(",", "").replaceAll('₹', "").trim();
    final splitValue = nValue.split('.');
    if (nValue.startsWith('.')) {
      nValue = splitValue.last.isNotEmpty ? '.${splitValue.last}' : '0.';
    } else if (nValue.contains('.')) {
      if (nValue.substring(nValue.indexOf('.') + 1).length > decimalRange) {
        nValue = oldText;
      } else {
        if (splitValue.length > 2) {
          nValue = '${splitValue[0]}.${splitValue[1]}';
        }
      }
    } else if (maxDigits != null && splitValue.first.length > maxDigits!) {
      nValue = oldText;
    }

    if (price != null && price == 0.0) {
      nValue = '0';
    }

    nSelection = newValue.selection
        .copyWith(baseOffset: nSelection.start, extentOffset: nSelection.end);
    final symbolText = !isSymbol ? nValue : '₹$nValue';
    return TextEditingValue(text: symbolText, composing: TextRange.empty);
  }
}

class PercentageNumbersFormatter extends TextInputFormatter {
  PercentageNumbersFormatter(
      {this.decimalRange = 2,
      this.isFullPercent = true,
      this.isSymbol = true,
      this.price});

  final int decimalRange;
  final bool isSymbol;
  final bool isFullPercent;
  final double? price;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String nValue = newValue.text;
    TextSelection nSelection = newValue.selection;

    Pattern p = RegExp(r'(\d+\.?)|(\.?\d+)|(\.?)');
    nValue = p
        .allMatches(nValue)
        .map<String>((Match match) => match.group(0)!)
        .join();

    final oldText = oldValue.text.replaceAll('%', '').trim();
    final splitValue = nValue.split('.');
    final percentValue = VgtsConstant.percentValue(nValue);
    final percentText = isFullPercent && percentValue >= 100 ? '100' : oldText;

    if (nValue.startsWith('.')) {
      nValue = splitValue.last.isNotEmpty ? '.${splitValue.last}' : '0.';
    } else if (nValue.contains('.')) {
      if (splitValue.first.length >= 3) {
        nValue = percentText;
      } else if (nValue.substring(nValue.indexOf('.') + 1).length >
          decimalRange) {
        nValue = oldText;
      } else {
        if (splitValue.length > 2) {
          nValue = '${splitValue[0]}.${splitValue[1]}';
        }
      }
    } else if (nValue.length >= 3) {
      nValue = percentText;
    }

    if (price != null && price == 0.0) {
      nValue = '0';
    }

    final symbolText = !isSymbol ? nValue : '$nValue%';
    int textLength = symbolText.length;

    nSelection = newValue.selection.copyWith(
      baseOffset: nSelection.baseOffset.clamp(0, textLength),
      extentOffset: nSelection.extentOffset.clamp(0, textLength),
    );

    return TextEditingValue(
        text: symbolText, selection: nSelection, composing: TextRange.empty);
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.endsWith(' ') && newValue.text.length != 1) {
      final String trimedText = '${newValue.text.trim()} ';
      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();
      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}
