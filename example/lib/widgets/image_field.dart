import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import 'package:vgts_plugin/services/image_picker_services.dart';
import 'package:vgts_plugin/vgts_plugin.dart';
import 'package:vgts_plugin_example/res/colors.dart';
import 'package:vgts_plugin_example/res/fontsize.dart';
import 'package:vgts_plugin_example/res/images.dart';

Color _focusBgColor = Color(0xffF8F9FF);
Color _errorColor = Color(0xffEB1414);

TextStyle _errorTextStyle = TextStyle(
    fontSize: AppFontSize.dp12,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.5,
    color: _errorColor);
TextStyle _labelTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: 0.5,
    color: AppColor.text);
TextStyle _bodyTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    letterSpacing: 0.15,
    color: AppColor.text);

// ignore: must_be_immutable
class ImageField extends StatefulWidget {
  ImageFieldController controller;
  EdgeInsets margin;

  double height;
  double width;
  String placeholder;

  ImageField(this.controller,
      {this.margin = EdgeInsets.zero,
      this.height = 200,
      this.width = 200,
      this.placeholder = Images.emptyProfile});

  @override
  _ImageFieldState createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  final BorderRadius _borderRadius = BorderRadius.circular(12.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: widget.margin,
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return Column(
            children: [
              InkWell(
                onTap: () async {
                  final picker = getIt<ImagePickerService>();
                  final images = await picker.pickImage(context,
                      isMultiPicker: false, isWaterMater: false);
                  if (images?.isNotEmpty == true) {
                    setState(() {
                      widget.controller.setValue(images!.first);
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: _borderRadius,
                      border: Border.all(
                          color: state.hasError ? _errorColor : _focusBgColor,
                          width: 2)),
                  child: ClipRRect(
                      borderRadius: _borderRadius,
                      child: widget.controller.value == null
                          ? Icon(
                              Icons.image,
                              size: 200,
                            )
                          : _ImageView(widget.controller.value!)),
                ),
              ),
              if (state.hasError)
                Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      state.errorText ?? '',
                      textScaleFactor: 1,
                      style: _errorTextStyle,
                    ))
            ],
          );
        },
        validator: (value) =>
            widget.controller.validator(widget.controller.value),
        initialValue: widget.controller.value?.path,
      ),
    );
  }
}

class _ImageView extends StatelessWidget {
  final File file;

  _ImageView(this.file);

  @override
  Widget build(BuildContext context) {
    return Image.file(
      file,
      fit: BoxFit.cover,
      cacheWidth: 200,
      cacheHeight: 200,
    );
  }
}
