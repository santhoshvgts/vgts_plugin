import 'dart:io';
import 'dart:math';

import 'package:intl/intl.dart';

sealed class VgtsConstant {
  static NumberFormat currencyFormatter(
      {String? name = 'INR',
      String? locale = 'en_IN',
      int? decimalDigits = 2,
      bool? isSubtract = false}) {
    final formatter = NumberFormat.currency(
        name: name,
        locale: locale,
        decimalDigits: decimalDigits,
        symbol: isSubtract == false ? '₹' : '-₹');
    return formatter;
  }

  static double percentValue(String value) {
    final formatValue = value.replaceAll('%', '').replaceAll('.', '').trim();
    return double.parse(formatValue.isEmpty ? '0' : formatValue);
  }

  static Future<String> getFileSize(String filepath, [int decimals = 2]) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }
}
