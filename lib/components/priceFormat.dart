import 'package:intl/intl.dart';

class PriceFormatter {
  static String formatPrice(String price) {
    double priceDouble = double.tryParse(price) ?? 0.0;
    return NumberFormat.simpleCurrency().format(priceDouble / 100);
  }
}