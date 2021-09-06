
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgts_plugin/form/base_object.dart';
import 'package:vgts_plugin/form/utils/input_formatter.dart';
import 'package:vgts_plugin/form/utils/input_validator.dart';

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

  NameFormFieldController(Key fieldKey,  { bool required = true, this.requiredText }) : super(fieldKey, required: required);

  @override
  String? Function(String? p1)? get validator => !this.required ? null : (String? p1) => InputValidator.nameValidator(p1, requiredText: requiredText);

  @override
  TextInputType get textInputType => TextInputType.name;

  @override
  List<TextInputFormatter> get inputFormatter => InputFormatter.nameFormatter;

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
  TextInputType get textInputType => TextInputType.numberWithOptions(decimal: true);

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

class FormFieldController {

  Key fieldKey;

  TextEditingController textEditingController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();

  TextCapitalization textCapitalization = TextCapitalization.none;

  String? Function(String?)? validator = (String? p1) => InputValidator.emptyValidator(p1,);
  List<TextInputFormatter> inputFormatter = InputFormatter.defaultFormatter;

  TextInputType textInputType;

  bool required;

  int maxLength;
  int minLines;
  int maxLines;

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
    this.required = false
  });

}

class DropdownFieldController<T extends BaseObject> {

  Key fieldKey;
  FocusNode focusNode = new FocusNode();
  T? value;
  List<T> dataList;
  String keyId;
  String valueId;
  bool required;

  DropdownFieldController(this.fieldKey, { required this.keyId, required this.valueId, this.dataList = const [], this.required = true });

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
