import 'package:collection/collection.dart';

enum Currency {
  euro("EURO", "€"),
  pound("POUND", "£"),
  usd("USD", "\$"),
  lira("LIRA", "TL");

  const Currency(this.json, this.symbol);

  final String json;
  final String symbol;

  static Currency? fromString(String? value) {
    if (value == null) return null;
    return Currency.values.firstWhereOrNull((e) => e.json == value.toUpperCase());
  }

  String showWithNumber(num? amount, [bool decimal = false]) {
    if (amount == null) return "";
    if (decimal) {
      return "$symbol${amount.toStringAsFixed(2)}";
    } else {
      return "$symbol${amount.toInt()}";
    }
  }
}
