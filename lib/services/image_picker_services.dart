import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'add_text_watermark.dart';
import '../widget/choose_image_widget.dart';
import '../constants/vgts_constant.dart';

class ImagePickerService {
  final _picker = ImagePicker();

  Future<List<File>?> pickImage(BuildContext context,
      {bool cropImage = false,
      bool isCompressed = true,
      bool isMultiPicker = false,
      bool isWaterMater = true,
      String? waterMarkText}) async {
    try {
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

      if (selectedFile.isEmpty ||
          selectedFile.where((n) => n == null).isNotEmpty) {
        return [];
      }

      showLoadingIndicator(context);

      final imagesList = selectedFile.map((e) => File(e!.path)).toList();

      List<File> waterMarkFiles = [];
      if (isWaterMater && imagesList.isNotEmpty) {
        for (final e in imagesList) {
          final formatter = DateFormat('dd/MM/yyyy h:mm a');
          final waterMarkFile = await AddTextWaterMark.addTextWaterMark(e,
              text: waterMarkText ?? '${formatter.format(DateTime.now())}');
          waterMarkFiles.add(waterMarkFile!);
        }
      }

      List<File> files = [];

      if (isCompressed) {
        for (final e in waterMarkFiles) {
          final path = e.path;
          final convertImage =
              path.contains('.png') ? await convertPngToJpg(path) : e;
          final compressed = await _compressImage(convertImage);
          if (compressed != null) files.add(File(compressed.path));
        }
      }

      Navigator.pop(context);
      if (files.isEmpty) return waterMarkFiles;
      return files;
    } catch (e) {
      return null;
    }
  }

  Future<File> convertPngToJpg(String path) async {
    final jpgPath = '${path.replaceAll('.png', '.jpg')}';
    final image = img.decodeImage(File(path).readAsBytesSync());
    final jpgImage = img.encodeJpg(image!, quality: 50);
    final file = await File(jpgPath).writeAsBytes(jpgImage);
    debugPrint('jpg file path ${file.path}');
    return file;
  }

  Future<XFile?> _compressImage(File? image) async {
    final path = image?.path;
    final dir = await VgtsConstant.createTempDirectory();
    final isPng = path?.contains('.png') == true;
    debugPrint(
        'image-size before compress : ${path != null ? await VgtsConstant.getFileSize(path) : 0}');

    final file = await FlutterImageCompress.compressAndGetFile(
        path!, '${dir.$1.absolute.path}/${dir.$2}.jpg',
        format: (isPng) ? CompressFormat.png : CompressFormat.jpeg,
        minWidth: 600,
        minHeight: 500,
        quality: 70);
    debugPrint(
        'image-size after compress :  ${file != null ? await VgtsConstant.getFileSize(path) : 0}');
    return file;
  }

  Future<File?> imageCropper(File? selectedFile) async {
    final path = selectedFile?.path;
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
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
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
