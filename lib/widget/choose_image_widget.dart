import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageWidget extends StatelessWidget {
  final String? title;
  final String? cameraTitle;
  final String? galleryTitle;

  const ChooseImageWidget(
      {super.key, this.title, this.cameraTitle, this.galleryTitle});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        title ?? 'Pick Image',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      actions: [
        _CupertinoActionItem(
          onTap: () {
            Navigator.pop(context, ImageSource.camera);
          },
          text: cameraTitle ?? 'Camera',
        ),
        _CupertinoActionItem(
          onTap: () {
            Navigator.pop(context, ImageSource.gallery);
          },
          text: galleryTitle ?? 'Gallery',
        ),
        _CupertinoActionItem(
          isDestructiveAction: true,
          text: 'Close',
        ),
      ],
    );
  }
}

class _CupertinoActionItem extends StatelessWidget {
  const _CupertinoActionItem(
      {this.text, this.isDestructiveAction = false, this.onTap});
  final String? text;
  final Function? onTap;
  final bool isDestructiveAction;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheetAction(
      isDestructiveAction: isDestructiveAction,
      onPressed: () {
        if (onTap == null) return Navigator.pop(context);
        onTap!();
      },
      child: Text(text!),
    );
  }
}
