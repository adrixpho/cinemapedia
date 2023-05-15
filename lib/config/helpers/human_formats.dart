import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en',
    ).format(number);

    return formatterNumber;
  }

  static String trimNumber({required double value, required int toDecimals}) {
    final strFormat = '###.${'#' * toDecimals}';
    final formatter = NumberFormat(strFormat);

    return formatter.format(value);
  }
}
