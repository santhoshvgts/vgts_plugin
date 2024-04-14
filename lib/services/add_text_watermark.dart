import 'dart:io';

import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import '../constants/vgts_constant.dart';

sealed class AddTextWaterMark {
  const AddTextWaterMark._();

  static Future<File>? addTextWaterMark(File? image, {String? text}) async {
    debugPrint(
        'image-size before waterMark :  ${await VgtsConstant.getFileSize(image!.path)}');
    final originalImage = img.decodeImage(image.readAsBytesSync());
    img.drawString(
      originalImage!,
      text!,
      font: img.arial24,
      x: originalImage.width - 235,
      y: originalImage.height - 60,
      color: originalImage.getColor(163, 162, 162),
    );
    final resizedImage = img.copyResize(originalImage, width: 600, height: 500);
    final tempDir =
        await VgtsConstant.createTempDirectory(fileName: basename(image.path));
    final path = tempDir.$1.path;
    File('$path/${tempDir.$2}.jpg')
        .writeAsBytesSync(img.encodeJpg(resizedImage, quality: 50));
    final imageFile = File(path + '/${tempDir.$2}.jpg');
    debugPrint(
        'image-size after waterMark :  ${await VgtsConstant.getFileSize(imageFile.path)}');
    return imageFile;
  }
}
