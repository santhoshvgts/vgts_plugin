

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vgts_plugin_example/res/colors.dart';

class ImageView extends StatelessWidget {

  final String image;
  final double height;
  final double width;
  final EdgeInsets? margin;

  ImageView(this.image, { this.height = 74, this.width = 74, this.margin });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child:Container(
        decoration: BoxDecoration(
          color: AppColor.secondaryBackground,
          shape: BoxShape.rectangle,
          // borderRadius: BorderRadius.circular(8),
        ),
        child: Image.memory(base64Decode(image), fit: BoxFit.cover,),
        //Image.file(controller.imageFile,width:104,height:104,fit: BoxFit.cover,),
        height: height,
        width: width,
        margin: margin
      ),
    );
  }

}