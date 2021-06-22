import 'package:flutter/material.dart';


enum FormInputDecorationType { Box, Line }

class FormFieldConfig {

  TextStyle textStyle;
  TextStyle labelStyle;
  TextStyle optionalStyle;
  TextStyle errorStyle;
  Color focusColor;
  Color fillColor;
  FormInputDecorationType type;

  FormFieldConfig({
      required this.textStyle,
      required this.labelStyle,
      required this.errorStyle,
      required this.optionalStyle,
      required this.fillColor,
      required this.focusColor,
      required this.type
  });

}