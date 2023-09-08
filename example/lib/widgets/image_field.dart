import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
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
      this.height = 104,
      this.width = 104,
      this.placeholder = Images.emptyProfile});

  @override
  _ImageFieldState createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  final ImagePicker _picker = ImagePicker();

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
                  ImageSource? imageSource = await showDialog<ImageSource>(
                      context: context,
                      builder: (context) => _PickImageOption());
                  if (imageSource == null) return;

                  final image = await _picker.pickImage(
                      source: imageSource, imageQuality: 50);
                  if (image == null) return;

                  Uint8List? result =
                      await FlutterImageCompress.compressWithFile(
                    image.path,
                    minWidth: 500,
                    minHeight: 500,
                    quality: 94,
                  );

                  setState(() {
                    widget.controller.setValue(base64Encode(result!));
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: _borderRadius,
                      border: Border.all(
                          color: state.hasError ? _errorColor : _focusBgColor,
                          width: 2)),
                  height: widget.height,
                  width: widget.width,
                  child: ClipRRect(
                      borderRadius: _borderRadius,
                      child: widget.controller.value == null
                          ? Image.asset(widget.placeholder)
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
        initialValue: widget.controller.value,
      ),
    );
  }
}

class _ImageView extends StatelessWidget {
  final String image;

  _ImageView(this.image);

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      base64Decode(image),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

class _PickImageOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Select Image Pick Option",
        textScaleFactor: 1,
        style: _labelTextStyle,
      ),
      titlePadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      contentPadding: EdgeInsets.zero,
      content: Wrap(
        children: [
          Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context, ImageSource.camera);
                    },
                    child: Text(
                      "Camera",
                      textScaleFactor: 1,
                      style: _bodyTextStyle,
                    ),
                  )),
              SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context, ImageSource.gallery);
                    },
                    child: Text(
                      "Gallery",
                      textScaleFactor: 1,
                      style: _bodyTextStyle,
                    ),
                  )),
            ],
          ),
        ],
      ),
      actions: [
        MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Close"))
      ],
    );
  }
}
