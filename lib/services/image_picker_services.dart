import 'dart:io';

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
      bool isMultiPicker = false,
      bool isWaterMater = true,
      String? waterMarkText}) async {
    ImageSource? imageSource = await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return ChooseImageWidget();
        });

    if (imageSource == null) return [];

    List<XFile?> selectedFile = isMultiPicker
        ? await _picker.pickMultiImage(imageQuality: 50)
        : [await _picker.pickImage(source: imageSource, imageQuality: 50)];

    if (selectedFile.isEmpty) return [];

    List<File> files = [];

    for (final e in selectedFile) {
      final file = File(e!.path);
      final compressed = await _compressImage(file);
      if (compressed != null) files.add(File(compressed.path));
    }

    List<File> waterMarkFiles = [];
    if (isWaterMater && files.isNotEmpty == true) {
      for (final e in files) {
        final formatter = DateFormat('dd/MM/yyyy h:mm a');
        final waterMarkFile = await AddTextWaterMark.addTextWaterMark(e,
            text: waterMarkText ?? '${formatter.format(DateTime.now())}\nVGTS');
        waterMarkFiles.add(waterMarkFile!);
      }
      files = waterMarkFiles;
    }
    return files;
  }

  Future<XFile?> _compressImage(File? filePath) async {
    final dir = await getTemporaryDirectory();
    return await FlutterImageCompress.compressAndGetFile(
        filePath!.absolute.path, dir.absolute.path + '/temp.jpg',
        minWidth: 500, minHeight: 500, quality: 94);
  }

  Future<File?> imageCropper(File? selectedFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: selectedFile!.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
    );
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }
}
