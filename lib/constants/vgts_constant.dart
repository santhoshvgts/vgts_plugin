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
}
