

import 'package:flutter/material.dart';
import 'package:vgts_plugin/form/config/form_field_config.dart';
import 'package:vgts_plugin/vgts_plugin.dart';

class BoxFieldInputDecoration extends InputDecoration {

  BoxFieldInputDecoration({ FocusNode? focusNode, Widget? prefix, Widget? prefixIcon, Widget? suffixIcon, String? counterText}) : super(
    // labelStyle: focusNode == null
    //     ? new TextStyle(color: Colors.black54)
    //     : (focusNode.hasFocus
    //     ? TextStyle(color: AppColor.primary)
    //     : TextStyle(color: Colors.black54)),
    fillColor: locator<FormFieldConfig>().fillColor,
    filled: true,
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    counterText: counterText,

    border: _outlineInputBorder,
    enabledBorder: _outlineInputBorder,
    disabledBorder: _outlineInputBorder,
    focusedBorder: _focusedInputBorder,
    errorBorder: _errorInputBorder,
    errorStyle: locator<FormFieldConfig>().errorStyle.copyWith(color: Colors.red),
    prefix: prefix,
    prefixIcon: prefixIcon,
    suffixIconConstraints: BoxConstraints(minWidth: 15, maxHeight: 20),
    suffixIcon: suffixIcon,
  );

}

InputBorder _outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: BorderSide(color: Colors.black38),
);

InputBorder _focusedInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: BorderSide(color: locator<FormFieldConfig>().focusColor, width: 2),
);

InputBorder _errorInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: BorderSide(color: Colors.red, width: 2),
);