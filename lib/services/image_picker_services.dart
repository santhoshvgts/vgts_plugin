import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
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
      String? source,
      String? waterMarkText}) async {
    try {
      ImageSource? imageSource;

      imageSource = source != null
          ? source == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery
          : await showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return ChooseImageWidget();
              });

      if (imageSource == null) return [];

      List<XFile?> selectedFile = await _pickImage({
        'isMultiPicker': isMultiPicker,
        'imageSource': imageSource,
      });

      if (selectedFile.isEmpty ||
          selectedFile.where((n) => n == null).isNotEmpty) {
        return [];
      }

      showLoadingIndicator(context);

      final imagesList = selectedFile.map((e) => File(e!.path)).toList();
      final tempDir = await getTemporaryDirectory();
      final waterText = waterMarkText ??
          DateFormat('dd/MM/yyyy h:mm a').format(DateTime.now());

      final files = await Future.wait(imagesList.map((image) async {
        File current = image;

        if (isWaterMater) {
          final inputPath = image.path;
          final outputPath =
              '${tempDir.path}/${Random().nextInt(1000000)}.jpg';
          current = await Isolate.run(
              () => AddTextWaterMark.processSync(inputPath, outputPath, waterText));
        }

        if (isCompressed) {
          if (current.path.endsWith('.png')) {
            final inputPath = current.path;
            final outputPath = inputPath.replaceAll('.png', '.jpg');
            current = await Isolate.run(() {
              final decoded =
                  img.decodeImage(File(inputPath).readAsBytesSync())!;
              File(outputPath)
                  .writeAsBytesSync(img.encodeJpg(decoded, quality: 50));
              return File(outputPath);
            });
          }
          final compressed = await _compressImage(current);
          if (compressed != null) current = File(compressed.path);
        }

        return current;
      }));

      Navigator.pop(context);
      return files;
    } catch (e) {
      return null;
    }
  }

  Future<List<XFile?>> _pickImage(Map params) async {
    bool isMultiPicker = params['isMultiPicker'];
    ImageSource? imageSource = params['imageSource'];
    if (isMultiPicker) return (await _picker.pickMultiImage(imageQuality: 50));
    return [await _picker.pickImage(source: imageSource!, imageQuality: 50)];
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
        'image-size after compress :  ${file != null ? await VgtsConstant.getFileSize(file.path) : 0}');
    return file;
  }

  Future<List<File>?> addWaterMarks(
      {List<File>? files,
      bool isWaterMater = true,
      String? waterMarkText}) async {
    if (!isWaterMater || files?.isNotEmpty != true) return files;
    final tempDir = await getTemporaryDirectory();
    final text = waterMarkText ??
        DateFormat('dd/MM/yyyy h:mm a').format(DateTime.now());
    return Future.wait(files!.map((e) async {
      final inputPath = e.path;
      final outputPath = '${tempDir.path}/${Random().nextInt(1000000)}.jpg';
      return Isolate.run(
          () => AddTextWaterMark.processSync(inputPath, outputPath, text));
    }));
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
