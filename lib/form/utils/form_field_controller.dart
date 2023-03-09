
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vgts_plugin/form/base_object.dart';
import 'package:vgts_plugin/form/utils/input_formatter.dart';
import 'package:vgts_plugin/form/utils/input_validator.dart';


//  Base Form Field Controller
//  This controller will be used as Parent class for pre templated form field
//
class FormFieldController {

  Key fieldKey;

  TextEditingController textEditingController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();

  TextCapitalization textCapitalization = TextCapitalization.none;

  String? Function(String?)? validator = (String? p1) => InputValidator.emptyValidator(p1,);
  List<TextInputFormatter> inputFormatter = InputFormatter.defaultFormatter;

  TextInputType textInputType;

  bool required;
  bool allowPaste;

  int maxLength;
  int minLines;
  int maxLines;

  String? overrideErrorText;

  String get text => textEditingController.text;

  set text(value) {
    textEditingController.text = value;
  }

  clear() {
    textEditingController.clear();
  }

  FocusNode get focusNode => _focusNode;

  bool get hasFocus => focusNode.hasFocus;

  FormFieldController(this.fieldKey, {
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.validator = InputValidator.emptyValidator,
    this.inputFormatter = const [],
    this.maxLength = 1000,
    this.minLines = 1,
    this.maxLines = 1000,
    this.required = false,
    this.allowPaste = true,
  });


  // FormFieldController.amount(this.fieldKey, {
  //   this.textInputType = TextInputType.text,
  //   this.textCapitalization = TextCapitalization.none,
  //   this.validator = InputValidator.emptyValidator,
  //   this.inputFormatter = const [],
  //   this.maxLength = 1000,
  //   this.minLines = 1,
  //   this.maxLines = 1000,
  //   this.required = false,
  // }) {
  //   this.textEditingController = _MoneyMaskedTextController(initialValue: 0, thousandSeparator: ",", decimalSeparator: ".", precision: 2);
  // }

  dispose(){
    _focusNode.dispose();
    _focusNode = FocusNode();
  }

}


//  Phone Form Field Controller
//  This controller used for only Phone Number Field
//
//  [Param]
//  * key - resourceId
//
//  [Optional Param]
//  * maxLength - length of the phone number, default will be 10
//  * required - default will be true
//
class PhoneFormFieldController extends FormFieldController {

  String? requiredText;

  PhoneFormFieldController(Key fieldKey, { int maxLength = 10, bool required = true, this.requiredText }) : super(fieldKey, maxLength: maxLength, required: required);

  @override
  List<TextInputFormatter> get inputFormatter => InputFormatter.phoneNoFormatter;

  @override
  String? Function(String? p1)? get validator => !this.required ? null : (String? p1) => InputValidator.phoneValidator(p1, requiredText: requiredText);

  @override
  TextInputType get textInputType => TextInputType.number;

  @override
  set maxLength(int _maxLength) {
    super.maxLength = _maxLength;
  }

}

class IdFormFieldController extends FormFieldController {

  String? requiredText;

  IdFormFieldController(Key fieldKey, { bool required = true, this.requiredText}) : super(fieldKey, required: required);

  @override
  String? Function(String? p1)? get validator => (String? p1) => InputValidator.idValidator(p1);

}


//  Email Address Form Field Controller
//  This controller used for only Email Address Field
//
//  [Param]
//  * key - resourceId
//
//  [Optional Param]
//  * required - default will be true
//
class EmailFormFieldController extends FormFieldController {

  String? requiredText;

  EmailFormFieldController(Key fieldKey,  { bool required = true,  this.requiredText  }) : super(fieldKey, required: required);

  @override
  String? Function(String? p1)? get validator => (String? p1) => InputValidator.emailValidator(p1, requiredText: requiredText);

  @override
  TextInputType get textInputType => TextInputType.emailAddress;

}

//  Multi Line Form Field Controller
//  This controller used for multiline text field like description, address.
//
//  [Param]
//  * key - resourceId
//
//  [Optional Param]
//  * minLines - length of the lines in text field, default will be 3
//  * required - default will be false
//
class MultiLineFormFieldController extends FormFieldController {

  MultiLineFormFieldController(Key fieldKey,  { bool required = false, int minLines = 3 }) : super(fieldKey, minLines: minLines, required: required);

  @override
  String? Function(String? p1)? get validator => !this.required ? null : super.validator;

  @override
  TextInputType get textInputType => TextInputType.multiline;

  @override
  TextCapitalization get textCapitalization => TextCapitalization.sentences;
}



//  Name Form Field Controller
//  This controller used for name text field like Full Name, Last Name.
//
//  [Param]
//  * key - resourceId
//
//  [Optional Param]
//  * required - default will be true
//
class NameFormFieldController extends FormFieldController {

  String? requiredText;

  bool _strictFormatter = false;

  NameFormFieldController(Key fieldKey,  { bool required = true, this.requiredText }) : super(fieldKey, required: required);

  NameFormFieldController.strict(Key fieldKey,  { bool required = true, this.requiredText }) : super(fieldKey, required: required) {
   _strictFormatter = true;
  }

  @override
  String? Function(String? p1)? get validator => !this.required ? null : (String? p1) => InputValidator.nameValidator(p1, requiredText: requiredText);

  @override
  TextInputType get textInputType => TextInputType.name;

  @override
  List<TextInputFormatter> get inputFormatter => _strictFormatter ? InputFormatter.nameStrictFormatter : InputFormatter.nameFormatter;

  @override
  TextCapitalization get textCapitalization => TextCapitalization.words;

}




//  Number Form Field Controller
//  This controller used for number text field like Amount, Quantity, Age etc.
//
//  [Param]
//  * key - resourceId
//
//  [Optional Param]
//  * required - default will be false
//
class NumberFormFieldController extends FormFieldController {

  String? requiredText;

  NumberFormFieldController(Key fieldKey,  { bool required = false, this.requiredText }) : super(fieldKey, required: required);

  @override
  String? Function(String? p1)? get validator => !this.required ? null : (String? p1) => InputValidator.numberValidator(p1, requiredText: requiredText);

  @override
  TextInputType get textInputType => TextInputType.numberWithOptions(decimal: true,);

  @override
  List<TextInputFormatter> get inputFormatter => InputFormatter.numberFormatter;

  @override
  TextCapitalization get textCapitalization => TextCapitalization.sentences;

}

//  Amount Form Field Controller
//  This controller used for number text field like Amount, Quantity, Age etc.
//
//  [Param]
//  * key - resourceId
//
//  [Optional Param]
//  * required - default will be false
//

class AmountFormFieldController extends FormFieldController {

  String? requiredText;

  AmountFormFieldController(Key fieldKey,  { bool required = false, this.requiredText }) : super(fieldKey, required: required);

  @override
  String get text {
    if (textEditingController.text.isEmpty == true) {
      return "";
    }

    NumberFormat formatter = NumberFormat.currency(
      name: "INR",
      locale: 'en_IN',
      decimalDigits: 0,
      symbol: '₹',
    );
    String value = textEditingController.text.replaceAll(" ", "");
    if (value.trim() == "₹"){
      return "";
    }
    return formatter.parse(textEditingController.text).toString();
  }

  @override
  set text(value) {
    NumberFormat formatter = NumberFormat.currency(
      name: "INR",
      locale: 'en_IN',
      decimalDigits: 0,
      symbol: '₹',
    );
    try {
      textEditingController.text = formatter.format(double.parse(value));
    } catch (ex) {
      print(value);
      print(ex);
      textEditingController.text = value;
    }
  }

  @override
  String? Function(String? p1)? get validator => !this.required ? null : (String? p1) => InputValidator.emptyValidator(p1, requiredText: requiredText);

  @override
  TextInputType get textInputType => TextInputType.numberWithOptions(decimal: true);

  @override
  List<TextInputFormatter> get inputFormatter => [ CurrencyInputFormatter(maxDigits: 50) ];

  @override
  bool get allowPaste => false;

  @override
  TextCapitalization get textCapitalization => TextCapitalization.sentences;

}


class AgeFormFieldController extends FormFieldController {
  String? requiredText;
  int minAge;

  AgeFormFieldController(Key fieldKey, {bool required = false, this.requiredText, this.minAge = 10}) : super(fieldKey, required: required);

  @override
  String? Function(String? p1)? get validator => !this.required
      ? null
      : (String? p1) {
    String? value = InputValidator.numberValidator(p1, requiredText: requiredText);
    if (value != null) {
      return value;
    }

    int age = int.tryParse(p1.toString()) ?? 0;
    if (age < minAge) {
      return "Age should be ${minAge} or above";
    }
  };

  @override
  int get maxLength => 2;

  @override
  TextInputType get textInputType => const TextInputType.numberWithOptions(decimal: false);

  @override
  List<TextInputFormatter> get inputFormatter => InputFormatter.numberFormatter;

  @override
  bool get allowPaste => false;

  @override
  TextCapitalization get textCapitalization => TextCapitalization.sentences;
}


class PercentageFormFieldController extends FormFieldController {
  String? requiredText;

  PercentageFormFieldController(Key fieldKey, {bool required = false, this.requiredText}) : super(fieldKey, required: required);

  @override
  String? Function(String? p1)? get validator => !this.required ? null : (String? p1) => InputValidator.numberValidator(p1, requiredText: requiredText);

  @override
  int get maxLength => 3;

  @override
  TextInputType get textInputType => const TextInputType.numberWithOptions(decimal: false, signed: false);

  @override
  bool get allowPaste => false;

  @override
  List<TextInputFormatter> get inputFormatter => InputFormatter.numberFormatter;

  @override
  TextCapitalization get textCapitalization => TextCapitalization.sentences;
}


//  Text Form Field Controller
//  This controller is the default controller that can be used for normal text. it allows any character.
//
//  [Param]
//  * key - resourceId
//
//  [Optional Param]
//  * required - default will be false
//
class TextFormFieldController extends FormFieldController {

  String? requiredText;

  TextInputType? inputType;

  TextCapitalization? textCapital;

  TextFormFieldController(Key fieldKey,  { bool required = false, this.inputType, this.textCapital, this.requiredText }) : super(fieldKey, required: required);

  @override
  String? Function(String? p1)? get validator => !this.required ? null : (String? p1) => InputValidator.emptyValidator(p1, requiredText: requiredText);

  @override
  TextInputType get textInputType => this.inputType??  TextInputType.text;

  @override
  TextCapitalization get textCapitalization => this.textCapital?? TextCapitalization.sentences;

}


class PasswordFormFieldController extends FormFieldController{

  String? requiredText;

  PasswordFormFieldController(Key fieldKey,  { bool required = true,  this.requiredText  }) : super(fieldKey, required: required);

  @override
  String? Function(String? p1)? get validator => (String? p1) => InputValidator.passwordValidator(p1, requiredText: requiredText);

  @override
  TextInputType get textInputType => TextInputType.visiblePassword;
}

//  Dropdown Form Field Controller
//  This controller is used for dropdownfield
//
//  [Param]
//  * key - resourceId
//
//  [Named Param]
//  * keyId - unique key to find the primaryKey value in Model
//  * valueId - unique key to find the displayText value in Model
//
//  [Optional Param]
//  * required - default will be false
//  * value - default value
//  * dataList - list of objects (object should extend BaseObject)
//
class DropdownFieldController<T extends BaseObject> {

  Key fieldKey;
  FocusNode focusNode = new FocusNode();
  T? value;
  List<T> dataList;
  String keyId;
  String valueId;
  bool required;

  DropdownFieldController(this.fieldKey, { required this.keyId, required this.valueId, this.value, this.dataList = const [], this.required = true });

  String? validator(T? value) {
    if (value == null && required)
      return "Required !";

    return null;
  }

  setValue(T? value) {
    this.value = value;
  }

  List<T> get list => dataList;

  set list(List<T> list) {
    this.value = null;
    this.dataList = list;
  }

  clear() {
    list = [];
  }

}

//  MultiSelection Form Field Controller
//  This controller is used for dropdownfield
//
//  [Param]
//  * key - resourceId
//
//  [Named Param]
//  * keyId - unique key to find the primaryKey value in Model
//  * valueId - unique key to find the displayText value in Model
//
//  [Optional Param]
//  * required - default will be false
//  * value - default selected list of value
//  * dataList - list of objects (object should extend BaseObject)
//
class MultiSelectionFieldController<T extends BaseObject> {

  Key fieldKey;
  FocusNode focusNode = new FocusNode();
  List<T> value;
  List<T> dataList;
  String keyId;
  String valueId;
  bool required;

  MultiSelectionFieldController(this.fieldKey, { required this.keyId, required this.valueId, this.value = const [], this.dataList = const [], this.required = true });

  String? validator(T? value) {
    if (value == null && required)
      return "Required !";

    return null;
  }

  setValue(List<T> value) {
    this.value = value;
  }

  List<T> get list => dataList;

  set list(List<T> list) {
    this.value = [];
    this.dataList = list;
  }

}



class ImageFieldController {

  Key fieldKey;
  FocusNode focusNode = new FocusNode();
  String? value;
  bool required;

  ImageFieldController(this.fieldKey, { this.value, this.required = true });

  setValue(String value){
    this.value = value;
  }

  String? validator(String? value) {
    if (required && value == null)
      return "Required !";

    return null;
  }

}


/// A [TextEditingController] extended to apply masks to currency values
class _MoneyMaskedTextController extends TextEditingController {
  _MoneyMaskedTextController({
    double? initialValue,
    this.decimalSeparator = ',',
    this.thousandSeparator = '.',
    this.rightSymbol = '',
    this.leftSymbol = '',
    this.precision = 2,
  }) {
    _validateConfig();
    _shouldApplyTheMask = true;

    addListener(() {
      if (_shouldApplyTheMask) {
        var parts = _getOnlyNumbers(text).split('').toList(growable: true);

        if (parts.isNotEmpty) {
          // Ensures that the list of parts contains the minimum amount of
          // characters to fit the precision
          if (parts.length < precision + 1) {
            parts = [...List.filled(precision, '0'), ...parts];
          }

          parts.insert(parts.length - precision, '.');
          updateValue(double.parse(parts.join()));
        }
      }
    });

    updateValue(initialValue);
  }

  /// Character used as decimal separator
  ///
  /// Defaults to ',' and must not be null.
  final String decimalSeparator;

  /// Character used as thousand separator
  ///
  /// Defaults to '.' and must not be null.
  final String thousandSeparator;

  /// Character used as right symbol
  ///
  /// Defaults to empty string. Must not be null.
  final String rightSymbol;

  /// Character used as left symbol
  ///
  /// Defaults to empty string. Must not be null.
  final String leftSymbol;

  /// Numeric precision to fraction digits
  ///
  /// Defaults to 2
  final int precision;

  /// The last valid numeric value
  double? _lastValue;

  /// Used to ensure that the listener will not try to update the mask when
  /// updating the text internally, thus reducing the number of operations when
  /// applying a mask (works as a mutex)
  late bool _shouldApplyTheMask;

  /// The numeric value of the text
  double get numberValue {
    final parts = _getOnlyNumbers(text).split('').toList(growable: true);

    if (parts.isEmpty) {
      return 0;
    }

    parts.insert(parts.length - precision, '.');
    return double.parse(parts.join());
  }

  static const int _maxNumLength = 12;

  /// Updates the value and applies the mask
  void updateValue(double? value) {
    if (value == null) {
      return;
    }

    double? valueToUse = value;

    if (value.toStringAsFixed(0).length > _maxNumLength) {
      valueToUse = _lastValue;
    } else {
      _lastValue = value;
    }

    final masked = _applyMask(valueToUse!);

    _updateText(masked);
  }

  /// Updates the [TextEditingController] and ensures that the listener will
  /// not trigger the mask update
  void _updateText(String newText) {
    if (text != newText) {
      _shouldApplyTheMask = false;

      final newSelection = _getNewSelection(newText);

      value = TextEditingValue(
        selection: newSelection,
        text: newText,
      );

      _shouldApplyTheMask = true;
    }
  }

  /// Returns the updated selection with the new cursor position
  TextSelection _getNewSelection(String newText) {
    // If baseOffset differs from extentOffset, user is selecting the text,
    // then we keep the current selection
    if (selection.baseOffset != selection.extentOffset) {
      return selection;
    }

    // When cursor is at the beginning, we set the cursor right after the first
    // character after the left symbol
    if (selection.baseOffset == 0) {
      return TextSelection.fromPosition(
        TextPosition(offset: leftSymbol.length + 1),
      );
    }

    // Cursor is not at the end of the text, so we need to calculate the updated
    // position taking into the new masked text and the current position for the
    // unmasked text
    if (selection.baseOffset != text.length) {
      try {
        // We take the number of leading zeros taking into account the behavior
        // when the text has only 4 characters
        var numberOfLeadingZeros =
            text.length - int.parse(text).toString().length;
        if (numberOfLeadingZeros == 2 && text.length == 4) {
          numberOfLeadingZeros = 1;
        }

        // Then we get the substring containing the characters to be skipped so
        // that we can position the cursor properly
        final skippedString =
        text.substring(numberOfLeadingZeros, selection.baseOffset);

        // Positions the cursor right after going through all the characters
        // that are in the skippedString
        var cursorPosition = leftSymbol.length + 1;
        if (skippedString != '') {
          for (var i = leftSymbol.length, j = 0; i < newText.length; i++) {
            if (newText[i] == skippedString[j]) {
              j++;
              cursorPosition = i + 1;
            }

            if (j == skippedString.length) {
              cursorPosition = i + 1;
              break;
            }
          }
        }

        return TextSelection.fromPosition(
          TextPosition(offset: cursorPosition),
        );
      } catch (_) {
        // If update fails, we set the cursor at end of the text
        return TextSelection.fromPosition(
          TextPosition(offset: newText.length - rightSymbol.length),
        );
      }
    }

    // Cursor is at end of the text
    return TextSelection.fromPosition(
      TextPosition(offset: newText.length - rightSymbol.length),
    );
  }

  /// Ensures [rightSymbol] does not contains numbers
  void _validateConfig() {
    if (_getOnlyNumbers(rightSymbol).isNotEmpty) {
      throw ArgumentError('rightSymbol must not have numbers.');
    }
  }

  String _getOnlyNumbers(String text) => text.replaceAll(RegExp(r'[^\d]'), '');

  /// Returns a masked String applying the mask to the value
  String _applyMask(double value) {
    final textRepresentation = value
        .toStringAsFixed(precision)
        .replaceAll('.', '')
        .split('')
        .reversed
        .toList(growable: true);

    textRepresentation.insert(precision, decimalSeparator);

    for (var i = precision + 4; textRepresentation.length > i; i += 4) {
      if (textRepresentation.length > i) {
        textRepresentation.insert(i, thousandSeparator);
      }
    }

    var masked = textRepresentation.reversed.join('');

    if (rightSymbol.isNotEmpty) {
      masked += rightSymbol;
    }

    if (leftSymbol.isNotEmpty) {
      masked = leftSymbol + masked;
    }

    return masked;
  }
}

