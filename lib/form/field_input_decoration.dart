

import 'package:flutter/material.dart';
import 'package:vgts_plugin/form/config/form_field_config.dart';
import 'package:vgts_plugin/vgts_plugin.dart';

class BoxFieldInputDecoration extends InputDecoration {

  BoxFieldInputDecoration({ FocusNode? focusNode, Widget? prefix, Widget? prefixIcon, Widget? suffixIcon, String? counterText, String? placeholder}) : super(
    // labelStyle: focusNode == null
    //     ? new TextStyle(color: Colors.black54)
    //     : (focusNode.hasFocus
    //     ? TextStyle(color: AppColor.primary)
    //     : TextStyle(color: Colors.black54)),
    fillColor: getIt<FormFieldConfig>().fillColor,
    filled: true,
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    counterText: counterText,

    border: _outlineInputBorder,
    enabledBorder: _outlineInputBorder,
    disabledBorder: _outlineInputBorder,
    focusedBorder: _focusedInputBorder,
    errorBorder: _errorInputBorder,
    errorStyle: getIt<FormFieldConfig>().errorStyle.copyWith(color: getIt<FormFieldConfig>().errorColor),
    prefix: prefix,

    hintText: placeholder,
    hintStyle: getIt<FormFieldConfig>().textStyle.copyWith(color: getIt<FormFieldConfig>().textStyle.color!.withOpacity(0.3)),

    prefixIcon: prefixIcon,
    suffixIconConstraints: BoxConstraints(minWidth: 15, maxHeight: 20),
    suffixIcon: suffixIcon,
  );

}

InputBorder _outlineInputBorder = OutlineInputBorder(
  borderRadius: getIt<FormFieldConfig>().borderRadius,
  borderSide: BorderSide(color: getIt<FormFieldConfig>().borderColor),
);

InputBorder _focusedInputBorder = OutlineInputBorder(
  borderRadius: getIt<FormFieldConfig>().borderRadius,
  borderSide: BorderSide(color: getIt<FormFieldConfig>().focusColor, width: 2),
);

InputBorder _errorInputBorder = OutlineInputBorder(
  borderRadius: getIt<FormFieldConfig>().borderRadius,
  borderSide: BorderSide(color: getIt<FormFieldConfig>().errorColor, width: 2),
);