import 'package:flutter/material.dart';


enum FormInputDecorationType { Box, Line }
enum FormInputLabelUIType { Default, Style1 }

class FormFieldConfig {

  TextStyle textStyle;
  TextStyle labelStyle;
  TextStyle optionalStyle;
  TextStyle errorStyle;
  Color focusColor;
  Color fillColor;
  Color borderColor;
  Color errorColor;
  BorderRadius borderRadius;
  FormInputDecorationType type;
  FormInputLabelUIType formInputLabelUIType;

  FormFieldConfig({
      required this.textStyle,
      required this.labelStyle,
      required this.errorStyle,
      required this.optionalStyle,
      required this.fillColor,
      required this.focusColor,
      required this.type,
      this.borderColor = Colors.black12,
      this.errorColor = Colors.red,
      this.borderRadius = const BorderRadius.all(Radius.circular(10)),
      this.formInputLabelUIType = FormInputLabelUIType.Default
  });

}