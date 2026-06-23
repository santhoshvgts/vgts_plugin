import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:vgts_plugin/services/image_picker_services.dart';

class PdfPickerServices {
  Future<List<File?>?> pickPdfFile(
      {List<String>? allowedExtensions,
      String? dialogTitle,
      String? waterMarkText,
      bool allowMultiple = false,
      FileType type = FileType.custom}) async {
    try {
      FilePickerResult? res = await FilePicker.pickFiles(
          dialogTitle: dialogTitle,
          type: type,
          allowMultiple: allowMultiple,
          allowedExtensions: allowedExtensions ?? ['jpg', 'png', 'pdf', 'doc']);
      if (res?.files.isNotEmpty == true) {
        List<File> files = [];
        for (final path in res!.paths) {
          if (path == null) continue;
          final ext = path.split('.').last.toLowerCase();
          if (ext == 'jpg' || ext == 'png') {
            final waterMarkImages = await ImagePickerService().addWaterMarks(
                files: [File(path)], waterMarkText: waterMarkText);
            if (waterMarkImages?.isNotEmpty == true) files.add(waterMarkImages!.first);
          } else {
            files.add(File(path));
          }
        }
        return files;
      }
      return null;
    } catch (e, s) {
      print('picker exception ${e.toString()},trace $s');
      throw FlutterErrorDetails(exception: e, stack: s);
    }
  }
}
