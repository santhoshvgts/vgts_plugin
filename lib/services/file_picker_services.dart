import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:vgts_plugin/services/image_picker_services.dart';

class FilePickerServices {
  Future<List<File?>?> pickPdfFile(
      {List<String>? allowedExtensions,
      String? dialogTitle,
      String? waterMarkText,
      bool allowMultiple = false,
      FileType type = FileType.custom}) async {
    try {
      FilePickerResult? res = await FilePicker.platform.pickFiles(
          dialogTitle: dialogTitle,
          type: type,
          allowMultiple: allowMultiple,
          allowedExtensions: allowedExtensions ?? ['jpg', 'png', 'pdf', 'doc']);
      if (res?.files.isNotEmpty == true) {
        List<File> files = [];
        for (final path in res!.paths) {
          if (path!.contains('.jpg') || path.contains('.png')) {
            final waterMarkImages = await ImagePickerService().addWaterMarks(
                files: [File(path)], waterMarkText: waterMarkText);
            if (waterMarkImages != null) files.add(waterMarkImages.first);
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
