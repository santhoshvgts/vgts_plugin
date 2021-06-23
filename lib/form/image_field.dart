
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vgts_plugin/form/config/form_field_config.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';

import '../vgts_plugin.dart';

class ImageField extends StatefulWidget {

  ImageFieldController controller;
  EdgeInsets margin;

  ImageField(this.controller, { this.margin = EdgeInsets.zero });

  @override
  _ImageFieldState createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {

  final ImagePicker _picker = ImagePicker();
  final FormFieldConfig _config = getIt<FormFieldConfig>();

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
                  ImageSource? imageSource = await showDialog<ImageSource?>(context: context, builder: (context) => _PickImageOption());
                  if (imageSource == null) return;

                  PickedFile? image = await _picker.getImage(source: imageSource, imageQuality: 50);
                  if (image == null) return;

                  Uint8List? result = await FlutterImageCompress.compressWithFile(
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
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: state.hasError ? getIt<FormFieldConfig>().errorColor : _config.fillColor, width: 2)
                  ),
                  height: 104,
                  width: 104,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: widget.controller.value == null ? Image.asset("assets/image_place_holder.png", package: "vgts_plugin",) : Image.memory(base64Decode(widget.controller.value!), width:104, height:104, fit: BoxFit.cover,),
                  ),
                ),
              ),

              if (state.hasError)
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(state.errorText!, textScaleFactor: 1, style: _config.errorStyle.copyWith(color: getIt<FormFieldConfig>().errorColor),)
                )
            ],
          );
        },
        validator: (value) => widget.controller.validator(widget.controller.value),
        initialValue: widget.controller.value,
      ),
    );
  }
}

class _PickImageOption extends StatelessWidget {

  final FormFieldConfig _config = getIt<FormFieldConfig>();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text("Select Image Pick Option", textScaleFactor: 1, style: _config.labelStyle,),
      titlePadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      contentPadding: EdgeInsets.zero,
      content: Wrap(
        children: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: (){
                    Navigator.pop(context, ImageSource.camera);
                  },
                  child: Text("Camera", textScaleFactor: 1, style: _config.textStyle,),
                )
              ),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: (){
                    Navigator.pop(context, ImageSource.gallery);
                  }, child: Text("Gallery", textScaleFactor: 1, style: _config.textStyle,),
                )
              ),
            ],
          ),
        ],
      ),
      actions: [
        MaterialButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Close"))
      ],
    );

  }

}