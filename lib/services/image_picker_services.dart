import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vgts_plugin/widget/choose_image_widget.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'add_text_watermark.dart';

class ImagePickerService {
  final _picker = ImagePicker();

  Future<List<File>?> pickImage(BuildContext context,
      {bool cropImage = false,
      bool isCompressed = true,
      bool isMultiPicker = false,
      bool isWaterMater = true,
      String? waterMarkText}) async {
    ImageSource? imageSource;

    imageSource = await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return ChooseImageWidget();
        });

    if (imageSource == null) return [];

    List<XFile?> selectedFile = isMultiPicker
        ? await _picker.pickMultiImage(imageQuality: 50)
        : [await _picker.pickImage(source: imageSource, imageQuality: 50)];

    showLoadingIndicator(context);

    if (selectedFile.isEmpty) {
      Navigator.pop(context);
      return [];
    }

    List<File> files =
        isCompressed ? [] : selectedFile.map((e) => File(e!.path)).toList();

    if (isCompressed) {
      for (final e in selectedFile) {
        final file = File(e!.path);
        final compressed = await _compressImage(file);
        if (compressed != null) files.add(File(compressed.path));
      }
    }

    List<File> waterMarkFiles = [];
    if (isWaterMater && files.isNotEmpty == true) {
      for (final e in files) {
        final formatter = DateFormat('dd/MM/yyyy h:mm a');
        final waterMarkFile = await AddTextWaterMark.addTextWaterMark(e,
            text: waterMarkText ?? '${formatter.format(DateTime.now())}');
        waterMarkFiles.add(waterMarkFile!);
      }
      files = waterMarkFiles;
    }

    Navigator.pop(context);
    return files;
  }

  Future<XFile?> _compressImage(File? filePath) async {
    final dir = await getTemporaryDirectory();
    final path = filePath?.absolute.path;
    final isPng = path?.contains('.png');
    return await FlutterImageCompress.compressAndGetFile(
        path!, '${dir.absolute.path}/temp.${isPng! ? 'png' : 'jpg'}',
        format: (isPng) ? CompressFormat.png : CompressFormat.jpeg,
        minWidth: 600,
        minHeight: 500,
        quality: 90);
  }

  Future<File?> imageCropper(File? selectedFile) async {
    final path = selectedFile?.absolute.path;
    final isPng = path?.contains('.png');
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: selectedFile!.path,
      compressFormat:
          (isPng == true) ? ImageCompressFormat.png : ImageCompressFormat.jpg,
      compressQuality: 100,
    );
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }

  void showLoadingIndicator(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: CupertinoActivityIndicator(),
                  ),
                  Text('Loading...',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)),
                ],
              ),
            ),
          );
        });
  }
}
