import "../models/currency.dart";

extension ToCurrency on Map {
  Currency toCurrency() {
    String code = this["code"];
    String name = this["name"];
    String symbol = this["symbol"];
    return Currency(code: code, name: name, symbol: symbol);
  }
}