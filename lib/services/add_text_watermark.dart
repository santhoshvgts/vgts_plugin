import 'dart:io';

import 'package:image/image.dart' as img;

sealed class AddTextWaterMark {
  const AddTextWaterMark._();

  /// Isolate-safe: no platform channels, pure file I/O + img. Outputs JPEG.
  static File processSync(String inputPath, String outputPath, String text) {
    final image = img.decodeImage(File(inputPath).readAsBytesSync())!;
    img.drawString(
      image,
      text,
      font: img.arial24,
      x: image.width - 235,
      y: image.height - 60,
      color: image.getColor(163, 162, 162),
    );
    File(outputPath).writeAsBytesSync(img.encodeJpg(image, quality: 85));
    return File(outputPath);
  }
}
