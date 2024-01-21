import 'package:intl/intl.dart';

class CurrencyUtils {
  static final formatCurrency =
      NumberFormat.currency(locale: "en_US", symbol: '\$', decimalDigits: 0);
}
