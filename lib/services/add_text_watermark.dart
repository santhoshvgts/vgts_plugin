import 'dart:io';
import 'dart:math';

import 'package:image/image.dart' as ui;
import 'package:path_provider/path_provider.dart';

sealed class AddTextWaterMark {
  const AddTextWaterMark._();

  static Future<File>? addTextWaterMark(File? image, {String? text}) async {
    final originalImage = ui.decodeImage(image!.readAsBytesSync());
    ui.drawString(originalImage!, text!,
        font: ui.arial24,
        x: originalImage.width - 200,
        y: originalImage.height - 60);
    final tempDir = await getTemporaryDirectory();
    final _random = Random();
    String randomFileName = _random.nextInt(10000).toString();
    File(tempDir.path + '/$randomFileName.png')
        .writeAsBytesSync(ui.encodePng(originalImage));
    return File(tempDir.path + '/$randomFileName.png');
  }
}
