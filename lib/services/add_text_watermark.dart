import 'dart:io';
import 'dart:math';

import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

sealed class AddTextWaterMark {
  const AddTextWaterMark._();

  static Future<File>? addTextWaterMark(File? image, {String? text}) async {
    final originalImage = img.decodeImage(image!.readAsBytesSync());
    img.drawString(originalImage!, text!,
        font: img.arial24,
        color: originalImage.getColor(163, 162, 162),
        x: originalImage.width - 200,
        y: originalImage.height - 60);
    final tempDir = await getTemporaryDirectory();
    final _random = Random();
    String randomFileName = _random.nextInt(10000).toString();
    File(tempDir.path + '/$randomFileName.png')
        .writeAsBytesSync(img.encodePng(originalImage));
    return File(tempDir.path + '/$randomFileName.png');
  }
}
